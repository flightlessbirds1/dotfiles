{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.android-tools
  ];
  services.udev = {
    enable = true;
    extraRules = ''
      SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", MODE="0666"
      SUBSYSTEM=="usb", ATTR{idVendor}=="1949", MODE="0666", GROUP="adbusers"
    '';
  };
}
