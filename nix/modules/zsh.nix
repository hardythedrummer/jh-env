{ ... }:

{
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

      # --- env vars ---
      export BITBUCKET_PAT="$(op read 'op://Employee/Bitbucket PAT/credential')"
      export JIRA_PAT="$(op read 'op://Employee/Jira PAT/credential')"

      # --- completion styles ---
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
      zstyle ':completion:*' menu select

      # --- key bindings ---
      bindkey -e
      bindkey '^[[A' history-search-backward
      bindkey '^[[B' history-search-forward

      # --- fnm ---
      eval "$(fnm env --use-on-cd --shell zsh)"

      # --- nix ---
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
    '';
  };
}
