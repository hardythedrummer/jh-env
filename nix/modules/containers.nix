{ config, pkgs, lib, ... }:

{
  services.colima = {
    enable = true;
  };

  home.packages = with pkgs; [
    docker
    docker-compose
    (writeShellScriptBin "docker-credential-1pass"
      (builtins.readFile ../../scripts/docker-credential-1pass.sh))
  ];

  # Merge credHelpers into ~/.docker/config.json without owning the whole file —
  # colima needs to write currentContext to it at runtime, so home.file won't work.
  # Using per-registry credHelpers instead of global credsStore so that public
  # registries (Docker Hub, ghcr.io, etc.) don't fail when no 1Password item exists.
  home.activation.dockerCredsStore = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    config="$HOME/.docker/config.json"
    registry="docker.internal.taillight.cloud"
    mkdir -p "$HOME/.docker"
    if [ ! -f "$config" ]; then
      echo '{}' > "$config"
    fi
    if [ "$(${pkgs.jq}/bin/jq -r --arg r "$registry" '.credHelpers[$r] // empty' "$config")" != "1pass" ]; then
      tmp=$(mktemp)
      ${pkgs.jq}/bin/jq --arg r "$registry" \
        '. + {"credHelpers": ((.credHelpers // {}) + {($r): "1pass"})} | del(.credsStore)' \
        "$config" > "$tmp" && mv "$tmp" "$config"
    fi
  '';
}