{ pkgs, ... }:

{
  programs.swaylock = {
    enable = true;
    settings = {
      font = "JetBrainsMono Nerd Font";
      font-size = 16;
      indicator-idle-visible = true;
      indicator-radius = 100;
      indicator-thickness = 20;
      show-failed-attempts = true;

      # Colors
      bs-hl-color = "ff6666";
      color = "1e1e2e";
      key-hl-color = "cba6f7";

      caps-lock-bs-hl-color = "ff6666";
      caps-lock-key-hl-color = "cba6f7";

      inside-color = "1e1e2e";
      inside-clear-color = "1e1e2e";
      inside-caps-lock-color = "1e1e2e";
      inside-ver-color = "1e1e2e";
      inside-wrong-color = "1e1e2e";

      line-color = "1e1e2e";
      line-clear-color = "1e1e2e";
      line-caps-lock-color = "1e1e2e";
      line-ver-color = "1e1e2e";
      line-wrong-color = "1e1e2e";

      ring-color = "11111b";
      ring-clear-color = "11111b";
      ring-caps-lock-color = "11111b";
      ring-ver-color = "11111b";
      ring-wrong-color = "11111b";

      separator-color = "00000000";

      text-color = "cdd6f4";
      text-clear-color = "cdd6f4";
      text-caps-lock-color = "cdd6f4";
      text-ver-color = "cdd6f4";
      text-wrong-color = "cdd6f4";
    };
  };
}
