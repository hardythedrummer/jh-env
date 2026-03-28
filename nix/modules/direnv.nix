{ pkgs, ... }:

{
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
    package = pkgs.direnv.overrideAttrs (old: {
      buildPhase = ''
        go build -ldflags '-X main.bashPath=${pkgs.bash}/bin/bash' -o direnv
      '';
    });
  };
}
