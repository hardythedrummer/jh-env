{
  description = "Joey's dev environment shells";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = fn: nixpkgs.lib.genAttrs systems (system: fn {
        pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
      });

      # packages included in every shell
      basePackages = pkgs: with pkgs; [
        git
        nodenv
        starship
        bat
        ripgrep
        jq
        direnv
        zsh-autosuggestions
        zsh-syntax-highlighting
      ];

      # export plugin paths for zshrc to source
      baseShellHook = pkgs: ''
        export ZSH_AUTOSUGGEST_PLUGIN="${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
        export ZSH_SYNTAX_HIGHLIGHT_PLUGIN="${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
      '';

      # helper to create a shell with base packages + extras
      mkDevShell = pkgs: { name, description, extraPackages ? [], shellHook ? "" }:
        pkgs.mkShell {
          inherit name description;
          packages = (basePackages pkgs) ++ extraPackages;
          shellHook = shellHook + (baseShellHook pkgs);
        };
    in
    {
      devShells = forAllSystems ({ pkgs }: {

        default = mkDevShell pkgs {
          name = "dev";
          description = "Base dev shell with git, node, and starship";
        };

        stripe = mkDevShell pkgs {
          name = "stripe";
          description = "Stripe dev shell with terraform and stripe-cli";
          extraPackages = with pkgs; [ 
            terraform 
            terragrunt 
            stripe-cli 
          ];
          shellHook = ''alias tf="terraform"'';
        };

        sage = mkDevShell pkgs {
          name = "data";
          description = "Data analysis shell with python, jupyter, and AWS";
          extraPackages = with pkgs; [
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
