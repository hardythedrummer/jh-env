#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

link() {
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [ -L "$dst" ]; then
    rm "$dst"
  elif [ -e "$dst" ]; then
    echo "backing up $dst -> ${dst}.bak"
    mv "$dst" "${dst}.bak"
  fi
  ln -s "$src" "$dst"
  echo "linked $dst -> $src"
}

link "$DOTFILES/zsh/.zshrc"             "$HOME/.zshrc"
link "$DOTFILES/wezterm/wezterm.lua"    "$HOME/.wezterm.lua"
link "$DOTFILES/starship/starship.toml" "$HOME/.config/starship.toml"
link "$DOTFILES/vscode/settings.json"    "$HOME/Library/Application Support/Code/User/settings.json"
link "$DOTFILES/git/.gitconfig"          "$HOME/.gitconfig"
link "$DOTFILES/git/.gitconfig-personal" "$HOME/.gitconfig-personal"
link "$DOTFILES/git/.gitconfig-work"     "$HOME/.gitconfig-work"

echo "done. restart your shell to apply changes."
