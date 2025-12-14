{
  pkgs,
  flake,
  lib,
  ...
}:
lib.mkIf (flake.config.environment == "mine") {
  services.network-manager-applet.enable = true;
  home.packages = builtins.attrValues {
    inherit (pkgs)
      networkmanagerapplet
      ;
  };
}
