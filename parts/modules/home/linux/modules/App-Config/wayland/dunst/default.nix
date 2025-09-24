_: {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        font = "JetBrainsMono Nerd Font 12";
        background = "#1e1e2e";
        frame_color = "#cba6f7";
        foreground = "#cdd6f4";
        corner_radius = 10;
        fade_in_duration = 1000;
        frame = 10000;
        frame_width = 1;
        icon_corner_radius = 10;
        monitor = 1;
        offset = "20x20";
        origin = "bottom-right";
        progress_bar_corner_radius = 4;
        timeout = 10;
        transparency = true;
      };

      urgency_critical = {
        frame_color = "#f38ba8";
        timeout = 0;
      };

      skip-rule = {
        appname = "flameshot";
        skip_display = true;
      };
    };
  };
}
