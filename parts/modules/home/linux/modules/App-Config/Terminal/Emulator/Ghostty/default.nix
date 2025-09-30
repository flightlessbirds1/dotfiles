_: {
  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "JetBrainsMono Nerd Font Mono";
      font-size = 12;
      font-feature = "+liga";
      font-thicken = false;
      font-synthetic-style = true;
      adjust-font-baseline = "1";
      adjust-underline-position = "-3";
      adjust-underline-thickness = "200%";
      adjust-strikethrough-position = "1";
      adjust-strikethrough-thickness = "120%";
      adjust-overline-position = "2";
      adjust-overline-thickness = "130%";
      adjust-box-thickness = "120%";

      window-decoration = true;
      window-padding-x = 20;
      window-padding-y = 16;
      window-padding-balance = true;
      window-padding-color = "background";
      window-theme = "dark";
      window-inherit-font-size = true;
      window-save-state = "always";
      window-step-resize = true;
      window-height = 48;
      window-width = 130;
      window-new-tab-position = "current";

      # theme = "catppuccin-macchiato";
      background = "24273a";
      foreground = "cad3f5";
      background-opacity = 0.85;
      background-blur = 20;

      cursor-color = "8bd5ca";
      cursor-text = "1e2030";
      cursor-style = "bar";
      cursor-style-blink = true;
      cursor-opacity = 0.95;
      cursor-invert-fg-bg = false;
      cursor-click-to-move = true;
      adjust-cursor-thickness = "60%";
      adjust-cursor-height = "40%";

      mouse-hide-while-typing = true;
      mouse-scroll-multiplier = 2.0;
      focus-follows-mouse = false;
      mouse-shift-capture = "never";
      click-repeat-interval = 400;

      clipboard-trim-trailing-spaces = true;
      clipboard-paste-protection = true;
      copy-on-select = false;
      clipboard-read = "ask";
      clipboard-write = "allow";

      window-inherit-working-directory = true;
      quit-after-last-window-closed = true;
      window-vsync = true;
      confirm-close-surface = false;
      initial-window = true;

      unfocused-split-opacity = 0.85;
      split-divider-color = "5b6078";

      image-storage-limit = 512000000;
      scrollback-limit = 200000;
      shell-integration = "detect";
      shell-integration-features = "cursor,sudo,title";
      title-report = true;
      link-url = true;
      bold-is-bright = false;

      quick-terminal-position = "center";
      quick-terminal-screen = "main";
      quick-terminal-animation-duration = 0.25;
      quick-terminal-autohide = true;
      resize-overlay = "never";
      resize-overlay-position = "center";
      resize-overlay-duration = "500ms";

      gtk-titlebar = false;
      gtk-tabs-location = "hidden";
      gtk-wide-tabs = false;
      # gtk-adwaita = false;

      working-directory = "home";
      grapheme-width-method = "unicode";
      osc-color-report-format = "16-bit";
      vt-kam-allowed = false;
      window-colorspace = "display-p3";
    };
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
