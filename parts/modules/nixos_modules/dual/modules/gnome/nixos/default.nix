{
  inputs,
  pkgs,
  lib,
  config,
  username,
  ...
}: let
  cfg = config.dual_modules.modules.gnome;
in {
  imports = [
    ./normal_gnome.nix
  ];
  environment.pathsToLink =
    if cfg.enable
    then ["/share/wayland-sessions"]
    else [];
  services.xserver.enable = lib.mkIf cfg.enable true;
  services.xserver.xkb.layout = "us";

  environment.gnome.excludePackages =
    if cfg.enable
    then
      (builtins.attrValues {
        inherit
          (pkgs)
          gnome-photos
          gnome-tour
          gedit
          cheese # webcam tool
          gnome-terminal
          geary
          epiphany # web browser
          evince # document viewer
          totem # video player
          gnome-music
          gnome-characters
          gnome-maps
          tali # poker game
          iagno # go game
          hitori # sudoku game
          atomix # puzzle game
          ;
      })
    else [];
}
