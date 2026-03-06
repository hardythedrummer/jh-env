# jh-env

Dev environment config: zsh, wezterm, starship, nix, vscode.

## Setup

```sh
# install wezterm, starship, nix (if not already)
brew install --cask wezterm
brew install starship
# nix: https://nixos.org/download

# symlink configs into place
./install.sh
```

## Structure

```
zsh/.zshrc              -> ~/.zshrc
wezterm/wezterm.lua     -> ~/.config/wezterm/wezterm.lua
starship/starship.toml  -> ~/.config/starship.toml
git/.gitconfig          -> ~/.gitconfig
vscode/settings.json    -> (copy manually via VS Code)
nix/                    -> project-level nix shells
```
