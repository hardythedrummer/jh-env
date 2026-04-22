{ pkgs, ... }:

{
  programs.bat.enable = true;
  programs.ripgrep.enable = true;
  programs.btop.enable = true;
  programs.jq.enable = true;
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  home.packages = with pkgs; [
    fnm
    httpie
  ];
}
