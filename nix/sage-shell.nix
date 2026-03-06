let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-25.05";
  pkgs = import nixpkgs { config = { allowUnfree = true; }; overlays = []; };
  baseShell = import ./shell.nix;
in

pkgs.mkShell {
  name = "sage-shell";
  inputsFrom = [ baseShell ];
  packages = with pkgs; [
    awscli2
    stripe-cli
    nbstripout
    (pkgs.python3.withPackages (python-pkgs: [
      python-pkgs.jupyter
      python-pkgs.jupyterlab
      python-pkgs.ipykernel
      python-pkgs.jupyterlab-lsp
      python-pkgs.python-dotenv
      python-pkgs.pandas
      python-pkgs.numpy
      python-pkgs.scipy
      python-pkgs.tabulate
      python-pkgs.pyarrow
    ]))
  ];
}
