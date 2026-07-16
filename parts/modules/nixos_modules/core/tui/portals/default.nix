{ pkgs, ... }:
{
  qt.enable = true;
  # qt.platformTheme = "gnome";
  qt.style = "adwaita-dark";
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
    };
    xdgOpenUsePortal = true;
    config.niri = {
      default = [
        "gtk"
        "gnome"
      ];
      "org.freedesktop.impl.portal.FileChooser" = "kde";
      # "org.freedesktop.impl.portal.OpenURI" = "gnome";
    };
    config.kde = {
      default = [
        "kde"
        "gtk"
      ];
    };
    config.common.default = [ "gnome" ];
  };
}
