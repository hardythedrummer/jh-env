# --- path ---
export PATH="$HOME/.local/bin:$HOME/bin:/usr/local/bin:/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

# --- history ---
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# --- completion ---
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select

# --- key bindings ---
bindkey -e
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# --- aliases ---
alias dc="docker compose"
alias dcps='docker compose ps --format "table {{.Service}}\t{{.Status}}\t{{.Ports}}"'
alias ls="ls --color=auto"
alias ll="ls -la"
alias gst="git status"
alias gd="git diff"
alias gl="git log --oneline -20"
alias gco="git checkout"
alias loc="git ls-files | grep \".*js$\" | xargs wc -l"

# --- nix shells ---
export JH_ENV="$HOME/code/jh/jh-env"
alias nix-dev="nix develop $JH_ENV --command zsh"
alias nix-stripe="nix develop $JH_ENV#stripe --command zsh"
alias nix-data="nix develop $JH_ENV#data --command zsh"

# --- nodenv ---
eval "$(nodenv init - zsh)"

# --- nix ---
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

# --- zsh plugins (from nix) ---
[ -n "$ZSH_AUTOSUGGEST_PLUGIN" ] && source "$ZSH_AUTOSUGGEST_PLUGIN"
[ -n "$ZSH_SYNTAX_HIGHLIGHT_PLUGIN" ] && source "$ZSH_SYNTAX_HIGHLIGHT_PLUGIN"

# --- syntax highlighting colors (tinacious) ---
ZSH_HIGHLIGHT_STYLES[command]='fg=#2ec84a'            # green — valid commands
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#2ec84a'            # green — builtins (cd, echo)
ZSH_HIGHLIGHT_STYLES[alias]='fg=#2ec84a'              # green — aliases
ZSH_HIGHLIGHT_STYLES[function]='fg=#2ec84a'           # green — functions
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#f9345e'      # red — unknown/invalid commands
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#f85b9e'      # pink — if, then, do, etc.
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#e7de40'   # yellow — 'strings'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#e7de40'   # yellow — "strings"
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#e7de40'   # yellow — $'strings'
ZSH_HIGHLIGHT_STYLES[path]='fg=#3c7dd2,underline'     # blue — valid paths
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#29b8db'            # cyan — wildcards (*.txt)
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#f85b9e'   # pink — ; && || pipes
ZSH_HIGHLIGHT_STYLES[redirection]='fg=#f85b9e'        # pink — > >> <
ZSH_HIGHLIGHT_STYLES[comment]='fg=#636363'             # dim — comments
ZSH_HIGHLIGHT_STYLES[arg0]='fg=#2ec84a'               # green — first word

# -- zoxide --
eval "$(zoxide init zsh)"

# --- direnv ---
[ -f /opt/homebrew/bin/direnv ] && eval "$(/opt/homebrew/bin/direnv hook zsh)"

# --- starship prompt (keep at end) ---
eval "$(starship init zsh)"
