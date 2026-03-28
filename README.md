# jh-env

Dev environment config: zsh, wezterm, starship, nix, vscode.

Managed with [home-manager](https://github.com/nix-community/home-manager) (standalone, no nix-darwin).

Theme: [Tinacious Design](https://github.com/tinacious/vscode-tinacious-design-syntax) across all tools.

## Prerequisites

- [Nix](https://nixos.org/download) (package manager)
- [WezTerm](https://wezfurlong.org/wezterm/) (`brew install --cask wezterm`)

## Setup

```sh
# install FiraCode Nerd Font + keychain secrets
./install.sh

# first-time home-manager activation (bootstraps via nix run)
nix --extra-experimental-features "nix-command flakes" run home-manager/master -- switch --flake ~/code/jh/jh-env

# allow direnv in ~/code
direnv allow ~/code
```

After the first activation, `home-manager` is on your PATH:

```sh
home-manager switch --flake ~/code/jh/jh-env
```

## Structure

```
flake.nix                -> home-manager config + project dev shells
nix/home.nix             -> all home-manager modules (zsh, git, direnv, etc.)
starship/starship.toml   -> ~/.config/starship.toml
wezterm/wezterm.lua      -> ~/.wezterm.lua
vscode/settings.json     -> ~/Library/Application Support/Code/User/settings.json
git/.gitconfig-personal  -> ~/.gitconfig-personal
git/.gitconfig-work      -> ~/.gitconfig-work
nix/nix.conf             -> ~/.config/nix/nix.conf
claude/settings.json     -> ~/.claude/settings.json
```

## What home-manager provides

Base tools always available in your shell: git, nodenv, starship, bat, ripgrep, jq, direnv, nix-direnv, zsh-autosuggestions, zsh-syntax-highlighting, httpie, btop, zoxide.

## Dev shells

Project-specific tools activated via direnv or manually:

| Shell | Command | Extra packages |
|-------|---------|----------------|
| stripe | `nix-stripe` | terraform, terragrunt, stripe-cli |
| sage | `nix-data` | python, jupyter, pandas, numpy, scipy |

Update all packages: `nix flake update`

## Git profiles

Git config uses `includeIf` to switch profiles by directory:

- `~/code/jh/*` -> personal (`hardythedrummer@gmail.com`)
- `~/code/*` -> work (`joey.hardy@taillight.com`)

Secrets (signing keys, etc.) go in `~/.gitconfig-work-local` — a local-only file included by the work profile, not tracked in this repo.
