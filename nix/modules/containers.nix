{ config, pkgs, lib, ... }:

{
  services.colima = {
    enable = true;
  };

  home.packages = with pkgs; [
    docker
    docker-compose
  ];
}