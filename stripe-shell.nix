let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
  pkgs = import nixpkgs { config = { allowUnfree = true; }; overlays = []; };
  baseShell = import ./shell.nix;
in

pkgs.mkShell {
  name = "stripe-dev-shell";
  inputsFrom = [ baseShell ];
  packages = with pkgs; [
    terraform
    stripe-cli
  ];

  shellHook=''
    alias tf="terraform"
  '';
}
