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

# --- keychain secrets ---
"$DOTFILES/keychain/setup.sh"

echo ""
echo "done. now run:"
echo "  home-manager switch --flake ~/code/jh/jh-env"
