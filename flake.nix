{
  description = "Joey's dev environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = fn: nixpkgs.lib.genAttrs systems (system: fn {
        pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
      });
    in
    {
      # --- home-manager configuration ---
      homeConfigurations."joey.hardy" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "aarch64-darwin";
          config.allowUnfree = true;
        };
        modules = [ ./nix/home.nix ];
      };

      # --- project-specific dev shells ---
      devShells = forAllSystems ({ pkgs }: {

        stripe = pkgs.mkShell {
          name = "stripe";
          description = "Stripe dev shell with terraform and stripe-cli";
          packages = with pkgs; [
            terraform
            terragrunt
            stripe-cli
          ];
        };

        sage = pkgs.mkShell {
          name = "data";
          description = "Data analysis shell with python, jupyter, and AWS";
          packages = with pkgs; [
            nbstripout
            (python3.withPackages (py: [
              py.jupyter
              py.jupyterlab
              py.ipykernel
              py.jupyterlab-lsp
              py.python-dotenv
              py.pandas
              py.numpy
              py.scipy
              py.tabulate
              py.pyarrow
            ]))
          ];
        };

      });
    };
}
