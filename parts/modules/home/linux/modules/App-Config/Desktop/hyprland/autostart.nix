{ config, ... }:
{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "swww img ~/Desktop/dotfiles/deploy/background-image.png"
      "swaync"
    ];
  };
}
