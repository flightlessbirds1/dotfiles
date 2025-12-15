{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.dual_modules.modules.gnome;
in
{
  imports = [
    ./electron_wayland.nix
  ];

  # When overlapped with keyd this causes major issues
  # services.xserver.xkb.variant = "colemak_dh";
  services.displayManager.gdm.enable = lib.mkIf cfg.enable true;
  services.desktopManager.gnome.enable = lib.mkIf cfg.enable true;

  services.gnome.gnome-browser-connector.enable = lib.mkIf cfg.enable true;

  environment.systemPackages = lib.mkIf cfg.enable (
    builtins.attrValues {
      inherit (pkgs)
        gnome-tweaks
        gnome-session
        gnome-shell
        gnome-settings-daemon
        xdg-desktop-portal-gnome
        ;
      inherit (pkgs.gnomeExtensions)
        appindicator
        compiz-windows-effect
        tiling-assistant
        logo-menu
        user-themes
        ;
      gnome-session-sessions = pkgs.gnome-session.sessions;
    }
  );

  services.displayManager.sessionPackages =
    if cfg.enable then [ pkgs.gnome-session.sessions ] else [ ];

  qt.enable = lib.mkIf cfg.enable true;
  # qt.platformTheme = "gnome";
  qt.style = lib.mkIf cfg.enable "adwaita-dark";
  xdg.portal = {
    enable = true;

    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gtk
      pkgs.kdePackages.xdg-desktop-portal-kde
    ];

    config.gnome = {
      default = [ "gnome" ];
      "org.freedesktop.impl.portal.ScreenCast" = "gnome";
      "org.freedesktop.impl.portal.Screenshot" = "gnome";
    };
    xdgOpenUsePortal = true;
    config.niri = {
      default = [
        "gnome"
        "gtk"
      ];
      "org.freedesktop.impl.portal.FileChooser" = "kde";
      # "org.freedesktop.impl.portal.OpenURI" = "gnome";
    };
    config.common.default = [ "gnome" ];
  };
}
