{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.dual_modules.modules.gnome;
in {
  imports = [
    ./electron_wayland.nix
  ];

  # When overlapped with keyd this causes major issues
  # services.xserver.xkb.variant = "colemak_dh";
  services.displayManager.gdm.enable = lib.mkIf cfg.enable true;
  services.desktopManager.gnome.enable = lib.mkIf cfg.enable true;

  services.gnome.gnome-browser-connector.enable = lib.mkIf cfg.enable true;

  environment.systemPackages = with pkgs;
    lib.mkIf cfg.enable [
      gnomeExtensions.appindicator
      gnomeExtensions.compiz-windows-effect
      gnomeExtensions.tiling-assistant
      gnomeExtensions.logo-menu
      gnomeExtensions.user-themes
      gnome-tweaks
      gnome-session
      gnome-shell
      gnome-settings-daemon
      xdg-desktop-portal-gnome
      gnome-session.sessions
    ];

  services.displayManager.sessionPackages =
    if cfg.enable
    then [pkgs.gnome-session.sessions]
    else [];

  qt.enable = lib.mkIf cfg.enable true;
  qt.platformTheme = "gnome";
  qt.style = "adwaita-highcontrastinverse";
  xdg.portal = {
    enable = true;

    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gtk
    ];

    config.gnome = {
      default = ["gnome"];
      "org.freedesktop.impl.portal.ScreenCast" = "gnome";
      "org.freedesktop.impl.portal.Screenshot" = "gnome";
    };

    config.niri = {
      default = ["wlr" "gtk"];
      "org.freedesktop.impl.portal.ScreenCast" = "wlr";
      "org.freedesktop.impl.portal.Screenshot" = "wlr";
    };
    config.common.default = ["gnome"];
  };
}
