# --- path ---
export PATH="$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH"

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

# --- nix shells ---
export JH_ENV="$HOME/code/jh/jh-env"
alias nix-dev="nix develop $JH_ENV"
alias nix-stripe="nix develop $JH_ENV#stripe"
alias nix-sage="nix develop $JH_ENV#sage"

# --- nodenv ---
eval "$(nodenv init - zsh)"

# --- nix ---
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

# --- starship prompt (keep at end) ---
eval "$(starship init zsh)"
