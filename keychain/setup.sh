#!/usr/bin/env bash
set -euo pipefail

# Define keychain entries: "service|account|description"
# Add new entries here as needed.
ENTRIES=(
  "claude-api-key|joey.hardy|Claude API key"
  "jira-pat|joey.hardy|JIRA personal access token"
  "bitbucket-pat|joey.hardy|Bitbucket personal access token"
)

for entry in "${ENTRIES[@]}"; do
  IFS='|' read -r service account description <<< "$entry"

  if security find-generic-password -a "$account" -s "$service" &>/dev/null; then
    echo "✓ $description already in keychain"
  else
    echo ""
    echo "Missing: $description (service=$service, account=$account)"
    printf "Enter value (or press Enter to skip): "
    read -rs value
    echo ""

    if [ -z "$value" ]; then
      echo "  skipped"
    else
      security add-generic-password -a "$account" -s "$service" -w "$value"
      echo "  added to keychain"
    fi
  fi
done

echo ""
echo "Keychain setup complete."
