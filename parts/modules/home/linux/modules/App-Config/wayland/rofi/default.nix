{ config, pkgs, ... }:
let
  inherit (config.lib.formats.rasi) mkLiteral;
in
{
  home.packages = [
    pkgs.pwmenu
    pkgs.iwmenu
    pkgs.bzmenu
    pkgs.wl-clipboard
  ];
  programs.rofi = {
    enable = true;

    plugins = [
      pkgs.rofi-top
    ];

    extraConfig = {
      modi = "drun,run,window,top";
      show-icons = true;
      terminal = "kitty";
      disable-history = false;
      hide-scrollbar = true;
      display-drun = "λ ";
      display-run = "λ ";
      display-window = "λ ";
      display-top = "λ ";
    };
    theme = {
      "*" = {
        base = mkLiteral "#1e1e2e";
        surface0 = mkLiteral "#313244";
        overlay0 = mkLiteral "#6c7086";
        text = mkLiteral "#cdd6f4";

        mauve = mkLiteral "#cba6f7";
        red = mkLiteral "#f38ba8";
        peach = mkLiteral "#fab387";
        green = mkLiteral "#a6e3a1";
        lavender = mkLiteral "#b4befe";

        background-color = mkLiteral "@base";
      };

      "window" = {
        height = mkLiteral "600";
        width = mkLiteral "1000";

        border = mkLiteral "3";
        border-radius = mkLiteral "10";
        border-color = mkLiteral "@lavender";
      };

      "mainbox" = {
        spacing = mkLiteral "0";
        children = mkLiteral "[inputbar, message, listview]";
      };

      "inputbar" = {
        color = mkLiteral "@text";
        padding = mkLiteral "14";
        background-color = mkLiteral "@base";
      };

      "message" = {
        padding = mkLiteral "10";
        background-color = mkLiteral "@overlay0";
      };

      "listview" = {
        padding = mkLiteral "8";
        border-radius = mkLiteral "0 0 10 10";
        border = mkLiteral "2 2 2 2";
        border-color = mkLiteral "@base";
        background-color = mkLiteral "@base";
        dynamic = false;
      };

      "textbox" = {
        text-color = mkLiteral "@text";
        background-color = mkLiteral "inherit";
      };

      "error-message" = {
        border = mkLiteral "20 20 20 20";
      };

      "entry, prompt, case-indicator" = {
        text-color = mkLiteral "inherit";
      };

      "prompt" = {
        margin = mkLiteral "0 10 0 0";
      };

      "element" = {
        padding = mkLiteral "5";
        vertical-align = mkLiteral "0.5";
        border-radius = mkLiteral "10";
        background-color = mkLiteral "@surface0";
      };

      "element.selected.normal" = {
        background-color = mkLiteral "@overlay0";
      };

      "element.alternate.normal" = {
        background-color = mkLiteral "inherit";
      };

      "element.normal.active, element.alternate.active" = {
        background-color = mkLiteral "@peach";
      };

      "element.selected.active" = {
        background-color = mkLiteral "@green";
      };

      "element.normal.urgent, element.alternate.urgent" = {
        background-color = mkLiteral "@red";
      };

      "element.selected.urgent" = {
        background-color = mkLiteral "@mauve";
      };

      "element-text, element-icon" = {
        size = mkLiteral "80";
        margin = mkLiteral "0 10 0 0";
        vertical-align = mkLiteral "0.5";
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "@text";
      };

      "element-text .active, element-text .urgent" = {
        text-color = mkLiteral "@base";
      };
    };
  };
}
