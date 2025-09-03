{
  config,
  lib,
  pkgs,
  flake,
  ...
}:
{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    # Use the BlueZ Bluetooth stack
    package = pkgs.bluez;
    settings = {
      General = {
        # Faster connection and better audio quality
        FastConnectable = true;
        # Enable A2DP sink, AVRCP, HSP, HFP profiles
        Class = "0x000100";
        # Default to allow pairing
        Pairable = true;
        # Auto accept pairing requests for selected devices only
        # JustWorksRepairing = "always";
      };
    };
  };

  # Enable the Bluetooth service
  services.blueman.enable = true;

  # Enable UPower service for battery status from Bluetooth devices
  services.upower.enable = true;

  # Add additional Bluetooth tools
  environment.systemPackages = with pkgs; [
    # Command line tools
    bluez
    bluez-tools

    blueberry # Alternative to blueman
  ];
}
