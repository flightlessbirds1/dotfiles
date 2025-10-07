{
  lib,
  flake,
  ...
}:
lib.mkIf (flake.config.environment == "mine") {
  services.swaync = {
    enable = true;
    settings = {
      positionX = "right";
      positionY = "bottom";
      layer = "overlay";
      control-center-layer = "top";
      layer-shell = true;
      cssPriority = "application";
      control-center-margin-top = 10;
      control-center-margin-bottom = 10;
      control-center-margin-right = 10;
      control-center-margin-left = 10;
      notification-2fa-action = true;
      notification-inline-replies = false;
      notification-icon-size = 64;
      notification-body-image-height = 100;
      notification-body-image-width = 200;
      timeout = 5;
      timeout-low = 3;
      timeout-critical = 0;
      fit-to-screen = true;
      control-center-width = 500;
      control-center-height = 600;
      notification-window-width = 500;
      keyboard-shortcuts = true;
      image-visibility = "when-available";
      transition-time = 150;
      hide-on-clear = false;
      hide-on-action = true;
      script-fail-notify = true;
    };
    style = ''
      @keyframes notification-fly-in {
        from {
          transform: translateX(300px);
          opacity: 0;
        }
        to {
          transform: translateX(0px);
          opacity: 1;
        }
      }
      @keyframes notification-fly-out {
        from {
          transform: translateX(0px);
          opacity: 1;
        }
        to {
          transform: translateX(300px);
          opacity: 0;
        }
      }
      * {
        font-family: "JetBrainsMono Nerd Font", "SF Pro Display", sans-serif;
        font-size: 14px;
      }
      .floating-notifications.background .notification-row .notification-background {
        box-shadow:
          0 8px 32px rgba(0, 0, 0, 0.4),
          0 4px 16px rgba(0, 0, 0, 0.3),
          inset 0 1px 0 rgba(255, 255, 255, 0.1);
        border-radius: 16px;
        margin: 12px;
        background: rgba(30, 30, 46, 0.85);

        backdrop-filter: blur(20px);
        border: 1px solid rgba(203, 166, 247, 0.2);
        color: #cdd6f4;
        padding: 0;
        animation: notification-fly-in 0.2s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        transition: all 0.15s ease;
      }
      .floating-notifications.background .notification-row .notification-background:hover {
        transform: translateY(-2px) scale(1.02);
        box-shadow:
          0 12px 40px rgba(0, 0, 0, 0.5),
          0 6px 20px rgba(0, 0, 0, 0.4),
          inset 0 1px 0 rgba(255, 255, 255, 0.15);
        border-color: rgba(203, 166, 247, 0.4);
      }
      .floating-notifications.background .notification-row .notification-background .notification {
        padding: 16px;
        border-radius: 16px;
        background: transparent;
      }
      .floating-notifications.background .notification-row .notification-background .notification.critical {
        background: linear-gradient(135deg, rgba(243, 139, 168, 0.1), rgba(243, 139, 168, 0.05));
        border: 1px solid rgba(243, 139, 168, 0.3);
        box-shadow:
          0 0 20px rgba(243, 139, 168, 0.2),
          0 8px 32px rgba(0, 0, 0, 0.4);
        animation: pulse 2s infinite;
      }
      @keyframes pulse {
        0%, 100% { box-shadow: 0 0 20px rgba(243, 139, 168, 0.2); }
        50% { box-shadow: 0 0 30px rgba(243, 139, 168, 0.4); }
      }
      .floating-notifications.background .notification-row .notification-background .notification .notification-content {
        margin: 4px 8px;
      }
      .floating-notifications.background .notification-row .notification-background .notification .notification-content .summary {
        color: #cdd6f4;
        font-weight: 600;
        font-size: 15px;
        margin-bottom: 6px;
        text-shadow: 0 1px 2px rgba(0, 0, 0, 0.3);
      }
      .floating-notifications.background .notification-row .notification-background .notification .notification-content .time {
        color: #a6adc8;
        font-size: 12px;
        opacity: 0.8;
      }
      .floating-notifications.background .notification-row .notification-background .notification .notification-content .body {
        color: #bac2de;
        font-size: 13px;
        line-height: 1.4;
        margin-top: 6px;
      }
      .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * {
        min-height: 3.4em;
      }
      .floating-notifications.background .notification-row .notification-background .notification > .notification-content {
        background: transparent;
      }

      .floating-notifications.background .notification-row .notification-background .close-button {
        background: linear-gradient(135deg, #f38ba8, #f9e2af);
        color: #1e1e2e;
        text-shadow: none;
        padding: 6px;
        border-radius: 50%;
        margin-top: 8px;
        margin-right: 12px;
        min-width: 28px;
        min-height: 28px;
        border: none;
        transition: all 0.15s ease;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.3);
      }
      .floating-notifications.background .notification-row .notification-background .close-button:hover {
        transform: scale(1.1);
        background: linear-gradient(135deg, #f9e2af, #f38ba8);
        box-shadow: 0 4px 16px rgba(243, 139, 168, 0.4);
      }
      .control-center {
        box-shadow:
          0 16px 64px rgba(0, 0, 0, 0.5),
          0 8px 32px rgba(0, 0, 0, 0.3),
          inset 0 1px 0 rgba(255, 255, 255, 0.1);
        border-radius: 20px;
        margin: 18px;
        background: rgba(30, 30, 46, 0.9);
        backdrop-filter: blur(30px);
        border: 1px solid rgba(203, 166, 247, 0.2);
        color: #cdd6f4;
        padding: 20px;
        transition: all 0.15s ease;
      }
      .control-center .widget-title {
        margin-bottom: 16px;
      }
      .control-center .widget-title > label {
        color: #cdd6f4;
        font-size: 18px;
        font-weight: 700;
        text-shadow: 0 1px 2px rgba(0, 0, 0, 0.3);
        background: linear-gradient(135deg, #cba6f7, #f9e2af);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
      }
      .control-center .widget-dnd {
        padding: 12px;
        background: rgba(49, 50, 68, 0.5);
        border-radius: 12px;
        margin: 8px 0;
        border: 1px solid rgba(69, 71, 90, 0.6);
        transition: all 0.15s ease;
      }
      .control-center .widget-dnd:hover {
        background: rgba(49, 50, 68, 0.7);
        border-color: rgba(203, 166, 247, 0.3);
      }
      .control-center .widget-dnd > switch {
        border-radius: 20px;
        background: linear-gradient(135deg, #313244, #45475a);
        border: 1px solid rgba(69, 71, 90, 0.8);
        transition: all 0.15s ease;
        min-height: 24px;

        min-width: 48px;
      }
      .control-center .widget-dnd > switch:checked {
        background: linear-gradient(135deg, #cba6f7, #b4befe);
        border-color: rgba(203, 166, 247, 0.8);
        box-shadow: 0 0 16px rgba(203, 166, 247, 0.3);
      }
      .control-center .widget-dnd > switch slider {
        background: linear-gradient(135deg, #f9e2af, #fab387);
        border-radius: 50%;
        transition: all 0.15s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.3);
      }
      .control-center .widget-dnd > switch:checked slider {
        background: linear-gradient(135deg, #ffffff, #f5f5f5);
      }
      .notification-row {
        outline: none;
        margin: 0;
        padding: 0;
      }
      .notification-row:focus-visible .notification-background {
        border-color: rgba(203, 166, 247, 0.6);
        box-shadow:
          0 0 0 2px rgba(203, 166, 247, 0.2),
          0 8px 32px rgba(0, 0, 0, 0.4);
      }
      progressbar {
        background: rgba(49, 50, 68, 0.8);
        border-radius: 12px;
        margin: 8px 0;
        overflow: hidden;
      }
      progressbar progress {
        background: linear-gradient(90deg, #cba6f7, #b4befe, #f9e2af);
        border-radius: 12px;
        transition: all 0.15s ease;
      }
      button {
        border-radius: 8px;
        padding: 8px 16px;
        background: linear-gradient(135deg, rgba(203, 166, 247, 0.2), rgba(180, 190, 254, 0.2));
        border: 1px solid rgba(203, 166, 247, 0.3);
        color: #cdd6f4;
        transition: all 0.15s ease;
        font-weight: 500;
      }
      button:hover {
        background: linear-gradient(135deg, rgba(203, 166, 247, 0.4), rgba(180, 190, 254, 0.4));
        border-color: rgba(203, 166, 247, 0.5);
        transform: translateY(-1px);
        box-shadow: 0 4px 12px rgba(203, 166, 247, 0.2);
      }
      button:active {
        transform: translateY(0px);
        box-shadow: 0 2px 6px rgba(203, 166, 247, 0.2);
      }
    '';
  };
}
