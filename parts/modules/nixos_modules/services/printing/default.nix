{ pkgs, ... }:
{
  services.printing = {
    enable = true;
    drivers = [
      pkgs.cups-filters
      pkgs.cups-browsed
      pkgs.brlaser
    ];
  };
  services.ipp-usb.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
