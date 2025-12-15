{ pkgs, ... }:
{
  programs.niri.settings.switch-events = {
    lid-close.action.spawn = "${pkgs.swaylock}/bin/swaylock && systemctl sleep";
    lid-open.action.spawn = "niri msg output eDP-1 on";
  };
}
