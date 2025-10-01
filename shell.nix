let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in

pkgs.mkShell {
  name = "dev-shell";
  command = "zsh";
  packages = with pkgs; [
    git
    nodenv
  ];

  shellHook = ''
    nodenv install 20.10.0
    nodenv global 20.10.0
  '';
}
