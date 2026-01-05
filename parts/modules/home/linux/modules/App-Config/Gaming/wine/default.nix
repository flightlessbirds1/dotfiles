{ pkgs, ... }:
{
  home.packages = [
    pkgs.wineWowPackages.waylandFull
    pkgs.winetricks
  ];
}
