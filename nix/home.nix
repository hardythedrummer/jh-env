{ pkgs, ... }:

{
  home.username = "joey.hardy";
  home.homeDirectory = "/Users/joey.hardy";
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

  # --- packages without dedicated modules ---
  home.packages = with pkgs; [
    nodenv
    httpie
  ];

  # --- zsh ---
  programs.zsh = {
    enable = true;

    history = {
      size = 10000;
      save = 10000;
      share = true;
      ignoreDups = true;
      ignoreSpace = true;
    };

    completionInit = "autoload -Uz compinit && compinit";

    autosuggestion.enable = true;

    syntaxHighlighting = {
      enable = true;
      styles = {
        command = "fg=#2ec84a";
        builtin = "fg=#2ec84a";
        alias = "fg=#2ec84a";
        "function" = "fg=#2ec84a";
        unknown-token = "fg=#f9345e";
        reserved-word = "fg=#f85b9e";
        single-quoted-argument = "fg=#e7de40";
        double-quoted-argument = "fg=#e7de40";
        dollar-quoted-argument = "fg=#e7de40";
        path = "fg=#3c7dd2,underline";
        globbing = "fg=#29b8db";
        commandseparator = "fg=#f85b9e";
        redirection = "fg=#f85b9e";
        comment = "fg=#636363";
        arg0 = "fg=#2ec84a";
      };
    };

    shellAliases = {
      dc = "docker compose";
      dcps = ''docker compose ps --format "table {{.Service}}\t{{.Status}}\t{{.Ports}}"'';
      ls = "ls --color=auto";
      ll = "ls -la";
      gst = "git status";
      gd = "git diff";
      gl = "git log --oneline -20";
      gco = "git checkout";
      loc = ''git ls-files | grep ".*js$" | xargs wc -l'';
      tf = "terraform";
      nix-stripe = "nix develop ~/code/jh/jh-env#stripe --command zsh";
      nix-data = "nix develop ~/code/jh/jh-env#sage --command zsh";
    };

    initContent = ''
      # --- path ---
      export PATH="$HOME/.local/bin:$HOME/bin:/usr/local/bin:/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

      # --- completion styles ---
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
      zstyle ':completion:*' menu select

      # --- key bindings ---
      bindkey -e
      bindkey '^[[A' history-search-backward
      bindkey '^[[B' history-search-forward

      # --- nodenv ---
      eval "$(nodenv init - zsh)"

      # --- nix ---
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
    '';
  };

  # --- git ---
  programs.git = {
    enable = true;
    
    settings = {
      user.name = "Joey Hardy";
      init.defaultBranch = "main";
      core.editor = "code --wait";
      pull.rebase = true;
      rerere.enabled = true;
      alias = {
        co = "checkout";
        br = "branch";
        st = "status";
        lg = "log --oneline --graph --decorate -20";
      };
    };
    includes = [
      {
        condition = "gitdir:~/code/jh/";
        path = "~/.gitconfig-personal";
      }
      {
        condition = "gitdir:~/code/";
        path = "~/.gitconfig-work";
      }
    ];
  };

  # --- direnv + nix-direnv ---
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

  # --- starship ---
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  # --- other programs with modules ---
  programs.bat.enable = true;
  programs.ripgrep.enable = true;
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.btop.enable = true;
  programs.jq.enable = true;

  # --- dotfiles without dedicated modules ---
  xdg.configFile."starship.toml".source = ../starship/starship.toml;
  xdg.configFile."nix/nix.conf".source = ./nix.conf;

  home.file = {
    ".wezterm.lua".source = ../wezterm/wezterm.lua;
    "Library/Application Support/Code/User/settings.json".source = ../vscode/settings.json;
    ".gitconfig-personal".source = ../git/.gitconfig-personal;
    ".gitconfig-work".source = ../git/.gitconfig-work;
    ".claude/settings.json".source = ../claude/settings.json;
    ".claude/get-key.sh" = {
      source = ../get-key.sh;
      executable = true;
    };
  };
}
