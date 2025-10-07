{
  pkgs,
  lib,
  flake,
  ...
}:
lib.mkIf (flake.config.environment == "mine")
{
  home.packages = with pkgs; [
    blueman
  ];
}
