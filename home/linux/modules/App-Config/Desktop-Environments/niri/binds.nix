{
  inputs,
  pkgs,
  lib,
  config,
  features,
  flake,
  username,
  hostname,
  ...
}: let
  a = config.lib.niri.actions;

  exe = lib.getExe;

  ws = {
    terminal = "01-terminal";
    web = "02-web";
    code = "03-code";
    music = "04-music";
    chat = "05-chat";
    files = "06-files";
    gaming = "07-gaming";
    misc = "08-misc";
  };

  script = "${config.home.homeDirectory}/Desktop/dotfiles/home/linux/modules/System-Config/start-scripts";

  helper = import ../../../../../../lib/Helper-Functions/System-dependent-checker.nix;
in {
  imports = [
    ./switch-binds.nix
  ];
  programs.niri = {
    settings = {
      binds = helper.system-dependent-checker {
        inherit
          username
          hostname
          ;
        concatenation_type = "attribute";
        portable_content = {
          "super+k".action = a.close-window;
          "super+period".action = a.set-column-width "+5%";
          "super+slash".action = a.set-column-width "-5%";
          "super+space".action = a.spawn [
            "${script}/fuzzel.sh"
          ];
          "super+comma".action = a.set-column-width "50%";

          # Focus Keybinds
          "super+left".action = a.focus-column-or-monitor-left;
          "super+right".action = a.focus-column-or-monitor-right;
          "super+down".action = a.focus-window-or-workspace-down;
          "super+up".action = a.focus-window-or-workspace-up;
          "super+f".action = a.maximize-column;
          "super+shift+f".action = a.fullscreen-window;

          # Move Window Keybinds
          "super+shift+left".action = a.move-column-left;
          "super+shift+right".action = a.move-column-right;
          "super+shift+down".action = a.move-window-down-or-to-workspace-down;
          "super+shift+up".action = a.move-window-up-or-to-workspace-up;

          # Workspace Switching
          "super+1".action = a.focus-workspace ws.terminal;
          "super+2".action = a.focus-workspace ws.web;
          "super+3".action = a.focus-workspace ws.code;
          "super+4".action = a.focus-workspace ws.music;
          "super+5".action = a.focus-workspace ws.chat;
          "super+6".action = a.focus-workspace ws.files;
          "super+7".action = a.focus-workspace ws.gaming;
          "super+8".action = a.focus-workspace ws.misc;

          # Move Window to Workspace (Currently not available in niri)
          # Waiting on https://github.com/sodiboo/niri-flake/issues/1018
          # "super+shift+1".action = a.move-window-to-workspace ws.terminal;
          # "super+shift+2".action = a.move-window-to-workspace ws.web;
          # "super+shift+3".action = a.move-window-to-workspace ws.code;
          # "super+shift+4".action = a.move-window-to-workspace ws.music;
          # "super+shift+5".action = a.move-window-to-workspace ws.chat;
          # "super+shift+6".action = a.move-window-to-workspace ws.files;
          # "super+shift+7".action = a.move-window-to-workspace ws.gaming;
          # "super+shift+8".action = a.move-window-to-workspace ws.misc;

          # App Launchers (SUPER + SHIFT + CTRL)
          "super+shift+ctrl+f".action = a.spawn "firefox";
          "super+shift+ctrl+slash".action = a.spawn "nu" "-c" ''firefox --no-remote -P "school"'';
          "super+shift+ctrl+v".action = a.spawn "vesktop";
          "super+shift+ctrl+g".action = a.spawn [
            "nu"
            "-c"
            ''ghostty -e "cd ~/Desktop/dotfiles && zellij"''
          ];
          "super+shift+ctrl+s".action = a.spawn "spotify";
          "super+shift+ctrl+i".action = a.spawn "nautilus";
          "super+shift+ctrl+d".action = a.spawn "${script}/steam.sh";
          "super+shift+ctrl+q".action = a.spawn "qbittorrent";
          "super+shift+ctrl+o".action = a.spawn "obsidian";
          "super+shift+v".action = a.spawn [
            "${config.home.homeDirectory}/Desktop/dotfiles/home/linux/modules/App-Config/wayland/cliphist/cliphist-fuzzel-img"
          ];
          "super+ctrl+shift+p".action = a.spawn [
            "${script}/plex.sh"
          ];
          "super+shift+ctrl+r".action = a.spawn [
            "resources"
          ];
          # System and Screenshot Keybinds (SUPER + ALT)
          "super+alt+r".action = a.spawn [
            "bash"
            "-c"
            "systemctl reboot"
          ];

          "super+alt+l".action = a.spawn [
            "niri"
            "msg"
            "action"
            "quit"
            "--skip-confirmation"
          ];
          "super+s".action = a.spawn [
            "grimshot"
            "copy"
            "anything"
          ];
          "super+alt+s".action = a.spawn [
            "grimshot"
            "copy"
            "active"
          ];

          # Move Window to Monitor Keybinds
          "super+ctrl+left".action = a.move-window-to-monitor-left;
          "super+ctrl+right".action = a.move-window-to-monitor-right;
          "super+ctrl+up".action = a.move-window-to-monitor-up;
          "super+ctrl+down".action = a.move-window-to-monitor-down;
          # Brightness Control
          "super+alt+d".action = a.spawn [
            "brightnessctl"
            "set"
            "5%-"
          ];
          "super+alt+u".action = a.spawn [
            "brightnessctl"
            "set"
            "+5%"
          ];
        };
        laptop_content = {
          "super+alt+delete".action = a.spawn [
            "bash"
            "-c"
            "systemctl poweroff"
          ];
          "super+alt+p".action = a.spawn [
            "nu"
            "-c"
            "systemctl suspend"
          ];
          "super+shift+r".action = a.spawn [
            "nu"
            "-c"
            "niri msg output eDP-1 off; niri msg output eDP-1 on"
          ];
        };
        desktop_content = {
          "super+alt+delete".action = a.spawn [
            "bash"
            "-c"
            "ddcutil setvcp 0xd6 5 --bus 7 --sleep-multiplier 4 && ddcutil setvcp 0xd6 5 --bus 8 --sleep-multiplier 4 && sleep 2 && systemctl poweroff"
          ];
          "super+alt+p".action = a.spawn [
            "nu"
            "-c"
            "nddcutil setvcp 0xd6 5 --bus 7 --sleep-multiplier 4; ddcutil setvcp 0xd6 5 --bus 8 --sleep-multiplier 4; systemctl suspend"
          ];
        };
        backup_content = {
          "super+alt+delete".action = a.spawn [
            "bash"
            "-c"
            "systemctl poweroff"
          ];
          "super+alt+p".action = a.spawn [
            "nu"
            "-c"
            "systemctl suspend"
          ];
        };
      };
    };
  };
}
