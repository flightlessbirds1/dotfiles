{ config, ... }:
{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "awww img ~/Desktop/dotfiles/deploy/background-image.png"
      "swaync"
    ];
  };
}
