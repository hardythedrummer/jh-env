{ config, pkgs, lib, ... }:

{
  services.colima = {
    enable = true;
  };

  home.packages = with pkgs; [
    docker
    docker-compose
    (writeShellScriptBin "docker-credential-op"
      (builtins.readFile ../../scripts/docker-credential-1pass.sh))
  ];

  # Merge credsStore into ~/.docker/config.json without owning the whole file —
  # colima needs to write currentContext to it at runtime, so home.file won't work.
  home.activation.dockerCredsStore = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    config="$HOME/.docker/config.json"
    mkdir -p "$HOME/.docker"
    if [ ! -f "$config" ]; then
      echo '{}' > "$config"
    fi
    if [ "$(${pkgs.jq}/bin/jq -r '.credsStore // empty' "$config")" != "op" ]; then
      tmp=$(mktemp)
      ${pkgs.jq}/bin/jq '. + {"credsStore": "op"}' "$config" > "$tmp" && mv "$tmp" "$config"
    fi
  '';
}