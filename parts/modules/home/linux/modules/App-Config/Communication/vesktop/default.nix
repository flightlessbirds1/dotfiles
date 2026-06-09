{ pkgs, pkgs-stable, ... }:
{
  home.packages = [
    pkgs-stable.vesktop
    pkgs.equibop
  ];
}
