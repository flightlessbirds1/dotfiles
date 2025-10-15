{config, ...}: {
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "${config.home.homeDirectory}/.local/bin/wallpaper-switcher"
      "swaync"
    ];
  };
}
