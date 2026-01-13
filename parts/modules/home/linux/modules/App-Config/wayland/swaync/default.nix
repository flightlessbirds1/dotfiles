{
  lib,
  flake,
  pkgs,
  ...
}:
lib.mkIf (flake.config.environment == "mine") {
  home.packages = [
    pkgs.libnotify
  ];
  services.swaync = {
    enable = true;
    settings = {
      positionX = "right";
      positionY = "bottom";
      timeout = 5;
      timeout-low = 3;
      timeout-critical = 0;
      notification-icon-size = 64;
      notification-body-image-height = 100;
      notification-body-image-width = 200;
      control-center-width = 500;
      control-center-height = 600;
      notification-window-width = 500;
      hide-on-action = true;
    };
    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font", sans-serif;
        font-size: 14px;
      }

      /* Floating notifications */
      .floating-notifications .notification-background {
        background: rgba(30, 30, 46, 0.85);
        backdrop-filter: blur(20px);
        border: 1px solid rgba(203, 166, 247, 0.2);
        border-radius: 16px;
        margin: 12px;
        padding: 16px;
      }

      .notification-background:hover {
        border-color: rgba(203, 166, 247, 0.4);
      }

      .notification.critical {
        background: rgba(243, 139, 168, 0.1);
        border: 1px solid rgba(243, 139, 168, 0.3);
      }

      .summary {
        color: #cdd6f4;
        font-weight: 600;
        font-size: 15px;
      }

      .body {
        color: #bac2de;
        font-size: 13px;
      }

      .time {
        color: #a6adc8;
        font-size: 12px;
      }

      /* Control center */
      .control-center {
        background: rgba(30, 30, 46, 0.9);
        backdrop-filter: blur(30px);
        border: 1px solid rgba(203, 166, 247, 0.2);
        border-radius: 20px;
        margin: 18px;
        padding: 20px;
      }

      .widget-title > label {
        color: #cdd6f4;
        font-size: 18px;
        font-weight: 700;
      }

      /* Buttons */
      button {
        background: rgba(203, 166, 247, 0.2);
        border: 1px solid rgba(203, 166, 247, 0.3);
        border-radius: 8px;
        color: #cdd6f4;
        padding: 8px 16px;
      }

      button:hover {
        background: rgba(203, 166, 247, 0.4);
      }
    '';
  };
}
