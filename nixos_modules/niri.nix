{
  inputs,
  pkgs,
  lib,
  config,
  flake,
  ...
}: {
  imports = [
    inputs.niri-flake.nixosModules.niri
  ];

  programs.niri.enable = true;

  # Enable screen sharing/streaming capabilities
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
    config.niri = {
      default = [
        "wlr"
        "gtk"
      ];
      "org.freedesktop.impl.portal.ScreenCast" = "wlr";
      "org.freedesktop.impl.portal.Screenshot" = "wlr";
    };
  };

  # Make sure PipeWire is enabled for screen sharing
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
}
