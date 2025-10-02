{
  lib,
  username,
  ...
}: {
  home.sessionVariables = {
    XDG_DATA_DIRS = lib.mkForce "/etc/profiles/per-user/${username}/share:/run/current-system/sw/share:/usr/share";
    NIXPKGS_ALLOW_UNFREE = 1;
    GTK_ICON_THEME = "Papirus";
    QT_QPA_PLATFORMTHEME = "gtk3";
    QS_ICON_THEME = "Papirus";
  };
}
