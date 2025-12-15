{
  pkgs,
  lib,
  flake,
  ...
}:
let
  base = "24273a";
  surface1 = "494d64";
  overlay1 = "8087a2";
  overlay2 = "939ab7";
  text = "cad3f5";
  rosewater = "f4dbd6";
  mauve = "c6a0f6";
  peach = "f5a97f";
  yellow = "eed49f";
  lavender = "b7bdf8";
in
lib.mkIf (flake.config.environment == "mine") {
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "JetBrainsMono Nerd Font:weight=medium:size=15";
        prompt = "  ";
        layer = "overlay";
        anchor = "center";

        width = 50;
        lines = 10;
        horizontal-pad = 32;
        vertical-pad = 24;
        inner-pad = 16;
        line-height = 32;
        icons-enabled = true;
        icon-theme = "Papirus-Dark";
        image-size-limit = 128;
        hide-before-typing = false;
        show-actions = true;
        fuzzy = true;
        exit-on-keyboard-focus-loss = true;
        terminal = "${pkgs.ghostty}/bin/ghostty";
        fields = "name,keywords,filename";
        password-character = "●";
        list-executables-in-path = true;
        launch-prefix = "";
      };

      colors = {
        background = "${base}f0";
        border = "${lavender}80";
        text = "${text}ff";

        prompt = "${mauve}ff";
        placeholder = "${overlay1}cc";
        input = "${text}ff";

        match = "${peach}ff";
        selection = "${surface1}e6";
        selection-text = "${rosewater}ff";
        selection-match = "${yellow}ff";
        counter = "${overlay2}b3";
      };

      border = {
        width = 2;
        radius = 18;
      };

      dmenu = {
        mode = "text";
        exit-immediately-if-empty = false;
        print-index = false;
      };

      key-bindings = {
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
