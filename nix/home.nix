{ ... }:

{
  home.username = "joey.hardy";
  home.homeDirectory = "/Users/joey.hardy";
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

  imports = [
    ./modules/zsh.nix
    ./modules/git.nix
    ./modules/direnv.nix
    ./modules/starship.nix
    ./modules/packages.nix
    ./modules/dotfiles.nix
    ./modules/claude.nix
  ];
}
