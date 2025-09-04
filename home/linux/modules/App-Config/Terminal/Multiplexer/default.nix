{
  pkgs,
  lib,
  ...
}: {
  programs.zellij = {
    enable = true;
    settings = {
      default-layout = "compact";
      theme = "custom-pink-theme";
      themes = {
        custom-pink-theme = {
          fg = "#FFFFFF";
          bg = "#1E1E1E";
          black = "#1E1E1E";
          red = "#FF6B6B";
          green = "#e879f9"; # Change this to make borders change around
          yellow = "#FFD93D";
          blue = "#6BCF7F";
          magenta = "#FF6BCF";
          cyan = "#4ECDC4";
          white = "#FFFFFF";
          orange = "#FFB347";
        };
      };
      show_startup_tips = false;
    };
  };
}
