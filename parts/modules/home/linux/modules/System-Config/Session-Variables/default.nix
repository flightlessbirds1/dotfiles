{lib, ...}: {
  home.sessionVariables = {
    XDG_DATA_DIRS = lib.mkForce "/etc/profiles/per-user/insomniac/share:/run/current-system/sw/share:/usr/share";
    DISPLAY = ":0";
    NIXPKGS_ALLOW_UNFREE = 1;
    GTK_ICON_THEME = "Papirus";
    QT_QPA_PLATFORMTHEME = "gtk3";
    QS_ICON_THEME = "Papirus";
  };
}
