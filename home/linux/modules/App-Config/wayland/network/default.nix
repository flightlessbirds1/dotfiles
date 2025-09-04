{pkgs, ...}: {
  services.network-manager-applet.enable = true;
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      networkmanagerapplet
      ;
  };
}
