{ ... }:

{
  xdg.configFile."nix/nix.conf".source = ../nix.conf;

  home.file = {
    ".wezterm.lua".source = ../../wezterm/wezterm.lua;
    "Library/Application Support/Code/User/settings.json".source = ../../vscode/settings.json;
  };
}
