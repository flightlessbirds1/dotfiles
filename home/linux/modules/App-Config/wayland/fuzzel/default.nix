{pkgs, ...}: let
  # Catppuccin Macchiato palette
  base = "24273a"; # window background. Do NOT change.
  mantle = "1e2030";
  crust = "181926";
  surface0 = "363a4f";
  surface1 = "494d64";
  surface2 = "5b6078";
  overlay0 = "6e738d";
  overlay1 = "8087a2";
  overlay2 = "939ab7";
  subtext0 = "a5adcb";
  subtext1 = "b8c0e0";
  text = "cad3f5";
  rosewater = "f4dbd6";
  flamingo = "f0c6c6";
  pink = "f5bde6";
  mauve = "c6a0f6";
  red = "ed8796";
  maroon = "ee99a0";
  peach = "f5a97f";
  yellow = "eed49f";
  green = "a6da95";
  teal = "8bd5ca";
  sky = "91d7e3";
  sapphire = "7dc4e4";
  blue = "8aadf4";
  lavender = "b7bdf8";
in {
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        # Premium typography with better hierarchy
        font = "JetBrainsMono Nerd Font:weight=medium:size=15";
        prompt = "  "; # More elegant prompt with search icon
        layer = "overlay";
        anchor = "center";

        # Refined dimensions for better proportions
        width = 50;
        lines = 10;
        horizontal-pad = 32;
        vertical-pad = 24;
        inner-pad = 16;
        line-height = 32; # More breathing room

        # Enhanced icon settings
        icons-enabled = true;
        icon-theme = "Papirus-Dark";
        image-size-limit = 128; # Larger, crisper icons

        # UX improvements
        hide-before-typing = false; # Show launcher immediately for better feedback
        show-actions = true;
        fuzzy = true;
        exit-on-keyboard-focus-loss = true;
        terminal = "${pkgs.ghostty}/bin/ghostty";
        fields = "name,keywords,filename"; # Include filename for better matching
        password-character = "●"; # Cleaner bullet

        # Performance and behavior tweaks
        list-executables-in-path = true;
        launch-prefix = ""; # Clean launch without prefix
      };

      colors = {
        # Sophisticated glassmorphism-inspired background
        background = "${base}f0"; # Slightly more opaque for better readability
        border = "${lavender}80"; # Softer, more subtle border
        text = "${text}ff";

        # Enhanced prompt styling with gradient feel
        prompt = "${mauve}ff";
        placeholder = "${overlay1}cc"; # More visible placeholder
        input = "${text}ff";

        # Refined matching colors for better visual hierarchy
        match = "${peach}ff"; # Warm accent for matches
        selection = "${surface1}e6"; # More prominent selection
        selection-text = "${rosewater}ff"; # Elegant selection text
        selection-match = "${yellow}ff"; # Bright highlight for selected matches

        # Subtle counter styling
        counter = "${overlay2}b3";
      };

      border = {
        width = 2; # Slightly thicker for more premium feel
        radius = 18; # More refined, less aggressive rounding
      };

      dmenu = {
        mode = "text";
        exit-immediately-if-empty = false;
        print-index = false; # Cleaner output
      };

      # Additional aesthetic section for key bindings
      key-bindings = {
        # More intuitive navigation
        cancel = "Escape Control+c Control+g";
        execute = "Return KP_Enter Control+m";
        execute-or-next = "Tab";
        cursor-left = "Left Control+b";
        cursor-right = "Right Control+f";
        cursor-home = "Home Control+a";
        cursor-end = "End Control+e";
        delete-prev = "BackSpace";
        delete-next = "Delete";
        extend-to-word-boundary = "";
        prev = "Up Control+p Control+k";
        next = "Down Control+n Control+j";
        page-up = "Page_Up Control+v";
        page-down = "Page_Down Alt+v";
        first = "Control+Home";
        last = "Control+End";
        delete-line = "Control+u";
        delete-word = "Control+w Alt+BackSpace";
        delete-word-forward = "Alt+d Control+Delete";
        prev-with-wrap = "ISO_Left_Tab";
        next-with-wrap = "Tab";
      };
    };
  };
}
