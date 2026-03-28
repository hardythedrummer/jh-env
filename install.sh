#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

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

# --- nix config (enables flakes before first home-manager run) ---
if [ ! -e ~/.config/nix/nix.conf ]; then
  mkdir -p ~/.config/nix
  cp "$DOTFILES/nix/nix.conf" ~/.config/nix/nix.conf
  echo "nix.conf installed"
else
  echo "nix.conf already exists, skipping"
fi

# --- keychain secrets ---
"$DOTFILES/keychain/setup.sh"

# --- home-manager ---
if command -v home-manager &>/dev/null; then
  home-manager switch --flake "$DOTFILES"
else
  nix run home-manager/master -- switch --flake "$DOTFILES"
fi
