{
  pkgs,
  lib,
  flake,
  config,
  ...
}:
let
  base = "24273a";
  surface1 = "494d64";
  text = "cad3f5";
  rosewater = "f4dbd6";
  mauve = "c6a0f6";
  peach = "f5a97f";
  yellow = "eed49f";
  lavender = "b7bdf8";
  inherit (config.lib.formats.rasi) mkLiteral;
  inherit (builtins) attrValues;
in
lib.mkIf (flake.config.environment == "mine") {
  home.packages = attrValues {
    inherit (pkgs)
      rofi-network-manager
      bzmenu
      ;
  };

  xdg.desktopEntries = (
    lib.genAttrs [ "Bluetooth" "Network" ] (name: {
      name = name;
      genericName = "Rofi Applet";
      exec = if name == "Bluetooth" then "bzmenu --launcher rofi" else "rofi-network-manager";
      terminal = false;
      categories = [
        "Application"
        "Network"
      ];
    })
  );
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.ghostty}/bin/ghostty";
    extraConfig = {
      show-icons = true;
      icon-theme = "Papirus-Dark";
      matching = "fuzzy";
      sort = true;
    };

    theme = {
      "*" = {
        bg = mkLiteral "#${base}f0";
        fg = mkLiteral "#${text}";
        border = mkLiteral "#${lavender}80";
        selected-bg = mkLiteral "#${surface1}e6";
        selected-fg = mkLiteral "#${rosewater}";
        match = mkLiteral "#${peach}";
        selected-match = mkLiteral "#${yellow}";
        prompt = mkLiteral "#${mauve}";

        background-color = mkLiteral "@bg";
        text-color = mkLiteral "@fg";

        font = "JetBrainsMono Nerd Font Medium 15";
      };

      window = {
        width = mkLiteral "50%";
        border = mkLiteral "2px";
        border-radius = mkLiteral "18px";
        border-color = mkLiteral "@border";
        padding = mkLiteral "24px";
      };

      mainbox = {
        spacing = mkLiteral "16px";
        background-color = mkLiteral "transparent";
      };

      inputbar = {
        spacing = mkLiteral "16px";
        children = map mkLiteral [
          "prompt"
          "entry"
        ];
        background-color = mkLiteral "transparent";
      };

      prompt = {
        text-color = mkLiteral "@prompt";
        background-color = mkLiteral "transparent";
      };

      entry = {
        background-color = mkLiteral "transparent";
      };

      listview = {
        lines = 10;
        background-color = mkLiteral "transparent";
      };

      element = {
        padding = mkLiteral "16px";
        spacing = mkLiteral "16px";
        border-radius = mkLiteral "12px";
        background-color = mkLiteral "transparent";
      };

      "element selected" = {
        background-color = mkLiteral "@selected-bg";
        text-color = mkLiteral "@selected-fg";
      };

      element-text = {
        highlight = mkLiteral "@match";
        background-color = mkLiteral "transparent";
      };

      "element-text selected" = {
        highlight = mkLiteral "@selected-match";
        background-color = mkLiteral "transparent";
      };

      element-icon = {
        size = mkLiteral "48px";
        background-color = mkLiteral "transparent";
      };

      "element-icon selected" = {
        background-color = mkLiteral "transparent";
      };
    };
  };
}
