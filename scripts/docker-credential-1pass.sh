#!/usr/bin/env bash
# docker-credential-op
#
# Docker credential helper backed by 1Password CLI (op).
# Each registry's credentials are stored as a Login item in a dedicated vault.
#
# Setup:
#   1. Add to ~/.docker/config.json:
#        { "credsStore": "op" }
#   2. Ensure op is signed in: op signin
#
# Configuration (environment variables):
#   DOCKER_CREDENTIAL_OP_VAULT  vault name to use (default: Employee)
#
# Non-nix install:
#   chmod +x docker-credential-op.sh
#   cp docker-credential-op.sh /usr/local/bin/docker-credential-op
#
# Dependencies: op (1Password CLI >= v2), jq

set -euo pipefail

VAULT="${DOCKER_CREDENTIAL_OP_VAULT:-Employee}"
TITLE_PREFIX="docker-cred"

_title() {
  # Strip trailing slash for a stable, canonical item title
  local server="${1%/}"
  echo "${TITLE_PREFIX}/${server}"
}

cmd_get() {
  local server item username secret
  server=$(</dev/stdin)
  server="${server%/}"
  exec </dev/null

  if ! item=$(op item get "$(_title "$server")" --vault "$VAULT" --format json 2>/dev/null); then
    printf 'credentials not found in 1Password for %s\n' "$server" >&2
    exit 1
  fi

  username=$(jq -r '.fields[] | select(.id == "username") | .value // empty' <<< "$item")
  secret=$(jq -r '.fields[] | select(.id == "password") | .value // empty' <<< "$item")

  jq -n --arg u "$username" --arg s "$secret" '{"Username":$u,"Secret":$s}'
}

cmd_store() {
  local input server username secret title
  input=$(</dev/stdin)
  exec </dev/null

  server=$(jq -r '.ServerURL' <<< "$input")
  server="${server%/}"
  username=$(jq -r '.Username' <<< "$input")
  secret=$(jq -r '.Secret' <<< "$input")
  title=$(_title "$server")

  if op item get "$title" --vault "$VAULT" &>/dev/null; then
    op item edit "$title" --vault "$VAULT" \
      "username=$username" \
      "password=$secret" \
      >/dev/null
  else
    op item create \
      --category Login \
      --vault "$VAULT" \
      --title "$title" \
      --url "$server" \
      "username=$username" \
      "password=$secret" \
      >/dev/null
  fi
}

cmd_erase() {
  local server
  server=$(</dev/stdin)
  server="${server%/}"
  exec </dev/null

  # Silently succeed if the item doesn't exist — docker doesn't care
  op item delete "$(_title "$server")" --vault "$VAULT" 2>/dev/null || true
}

cmd_list() {
  local items
  items=$(op item list --vault "$VAULT" --format json 2>/dev/null) || items='[]'

  # op puts the username in additional_information for Login items, avoiding
  # an individual op item get call per entry.
  jq --arg prefix "${TITLE_PREFIX}/" \
    'reduce (.[] | select(.title | startswith($prefix))) as $i
     ({}; .[$i.title[($prefix | length):]] = ($i.additional_information // ""))' \
    <<< "$items"
}

case "${1:-}" in
  get)   cmd_get ;;
  store) cmd_store ;;
  erase) cmd_erase ;;
  list)  cmd_list ;;
  *)
    printf 'docker-credential-op: unknown command %q\nUsage: docker-credential-op <get|store|erase|list>\n' "${1:-}" >&2
    exit 1
    ;;
esac