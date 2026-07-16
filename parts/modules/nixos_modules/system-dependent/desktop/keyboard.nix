{ pkgs, ... }:
{
  services.udev = {
    packages = with pkgs; [
      qmk
      qmk-udev-rules
      qmk_hid
      via
      vial
    ];
  };
  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      vial
      ;
  };
}
