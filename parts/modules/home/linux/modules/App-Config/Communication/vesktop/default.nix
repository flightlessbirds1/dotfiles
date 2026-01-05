{ pkgs-stable, pkgs, ... }:
{
  home.packages = [
    pkgs-stable.vesktop
    pkgs.equibop
  ];
}
