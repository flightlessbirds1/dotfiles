{
  wayland.windowManager.hyprland.settings = {
    bind =
      builtins.map (x: "SUPER, " + x) [
        # General Keybinds
        "K, killactive"
        "T, togglefloating"
        "period, splitratio, +0.1"
        "slash, splitratio, -0.1"
        "Space, exec, fuzzel"

        # Monitor Keybinds
        "1, workspace, 1"
        "2, workspace, 2"
        "3, workspace, 3"
        "4, workspace, 4"
        "5, workspace, 5"
        "6, workspace, 6"
        "7, workspace, 7"
        "8, workspace, 8"
        "9, workspace, 9"
        "left, movefocus, l"
        "right, movefocus, r"
        "down, movefocus, d"
        "up, movefocus, u"
        "S, exec, grimshot copy area"
      ]
      ++ builtins.map (x: "SUPER SHIFT CTRL, " + x) [
        # Workspaces
        "1, movetoworkspace, 1"
        "2, movetoworkspace, 2"
        "3, movetoworkspace, 3"
        "4, movetoworkspace, 4"
        "5, movetoworkspace, 5"
        "6, movetoworkspace, 6"
        "7, movetoworkspace, 7"
        "8, movetoworkspace, 8"
        "9, movetoworkspace, 9"

        # Apps
        "F, exec, firefox"
        "V, exec, vesktop"
        "G, exec, ghostty -e nu -c zellij"
        "S, exec, spotify"
        "I, exec, nautilus"
        "D, exec, steam"
      ]
      ++ builtins.map (x: "SUPER ALT, " + x) [
        "Delete, exec, shutdown now"
        "R, exec, systemctl reboot"
        "S, exec, grimshot copy active"
        "1, movecurrentworkspacetomonitor, DP-1"
        "2, movecurrentworkspacetomonitor, DP-2"
        "U, exec, brightnessctl set 5%-"
        "D, exec, brightnessctl set +5%"
        "E, exec, hyprctl dispatch exit"
      ];
    bindm = builtins.map (x: "SUPER, " + x) [
      "mouse:272, movewindow"
      "mouse:273, resizewindow"
    ];
  };
}
