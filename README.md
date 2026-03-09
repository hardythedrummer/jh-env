# jh-env

Dev environment config: zsh, wezterm, starship, nix, vscode.

Theme: [Tinacious Design](https://github.com/tinacious/vscode-tinacious-design-syntax) across all tools.

## Prerequisites

- [Nix](https://nixos.org/download) (package manager)
- [WezTerm](https://wezfurlong.org/wezterm/) (`brew install --cask wezterm`)

## Setup

```sh
# symlink configs + install FiraCode Nerd Font
./install.sh

# enter a dev shell (starship, nodenv, bat, direnv, etc.)
nix-dev
```

## Structure

```
flake.nix                -> nix dev shells (default, stripe, sage)
flake.lock               -> pinned nixpkgs-unstable
zsh/.zshrc               -> ~/.zshrc
wezterm/wezterm.lua      -> ~/.wezterm.lua
starship/starship.toml   -> ~/.config/starship.toml
vscode/settings.json     -> ~/Library/Application Support/Code/User/settings.json
git/.gitconfig           -> ~/.gitconfig
git/.gitconfig-personal  -> ~/.gitconfig-personal
git/.gitconfig-work      -> ~/.gitconfig-work
nix/nix.conf             -> ~/.config/nix/nix.conf
```

## Nix shells

All shells include: git, nodenv, starship, bat, direnv, zsh-autosuggestions, zsh-syntax-highlighting.

| Shell | Command | Extra packages |
|-------|---------|----------------|
| default | `nix-dev` | — |
| stripe | `nix-stripe` | terraform, terragrunt, stripe-cli |
| sage | `nix-sage` | python, jupyter, pandas, awscli, stripe-cli |

Update all packages: `nix flake update`

## Git profiles

Git config uses `includeIf` to switch profiles by directory:

- `~/code/jh/*` -> personal (`hardythedrummer@gmail.com`)
- `~/code/*` -> work (`joey.hardy@taillight.com`)

Secrets (signing keys, etc.) go in `~/.gitconfig-work-local` — a local-only file included by the work profile, not tracked in this repo.
