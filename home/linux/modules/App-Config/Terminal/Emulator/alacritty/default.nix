{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: {
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        opacity = 0.9;
        blur = true;
        decorations = "Full";
        padding = {
          x = 0;
          y = 5;
        };
        dynamic_title = true;
      };
      colors = {
        primary = {
          background = "#000000";
        };
      };
      font.normal = {
        family = "JetBrainsMonoNL Nerd Font Mono";
        style = "Regular";
      };
    };
  };
}
