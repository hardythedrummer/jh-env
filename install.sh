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

# --- fonts ---
if ls ~/Library/Fonts/FiraCode*.ttf &>/dev/null; then
  echo "FiraCode Nerd Font already installed, skipping"
else
  echo "installing FiraCode Nerd Font..."
  tmpdir=$(mktemp -d)
  curl -fsSL "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip" -o "$tmpdir/FiraCode.zip"
  unzip -qo "$tmpdir/FiraCode.zip" "*.ttf" -d ~/Library/Fonts/
  rm -rf "$tmpdir"
  echo "FiraCode Nerd Font installed"
fi

# --- symlinks ---
link "$DOTFILES/zsh/.zshrc"             "$HOME/.zshrc"
link "$DOTFILES/wezterm/wezterm.lua"    "$HOME/.wezterm.lua"
link "$DOTFILES/starship/starship.toml" "$HOME/.config/starship.toml"
link "$DOTFILES/vscode/settings.json"    "$HOME/Library/Application Support/Code/User/settings.json"
link "$DOTFILES/git/.gitconfig"          "$HOME/.gitconfig"
link "$DOTFILES/git/.gitconfig-personal" "$HOME/.gitconfig-personal"
link "$DOTFILES/git/.gitconfig-work"     "$HOME/.gitconfig-work"
link "$DOTFILES/nix/nix.conf"            "$HOME/.config/nix/nix.conf"

echo "done. restart your shell to apply changes."
