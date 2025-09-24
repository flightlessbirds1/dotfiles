{pkgs, ...}: {
  services.printing = {
    enable = true;
    drivers = [pkgs.hplipWithPlugin];
  };
  services.ipp-usb.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
