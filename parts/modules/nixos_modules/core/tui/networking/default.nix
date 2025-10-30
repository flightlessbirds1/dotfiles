{pkgs, ...}: {
  networking = {
    useNetworkd = true;
    dhcpcd.enable = false;
    networkmanager.enable = true;
    wireless.iwd = {
      enable = false;
    };
  };
  systemd.network.enable = true;
  systemd.network.wait-online.enable = false;
  environment.systemPackages = builtins.attrValues {
    inherit
      (pkgs)
      iw
      iwgtk
      ;
  };
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      22
      80
      443
      2096
      8443
      9443
      19216
      53317
    ];
    allowedUDPPorts = [
      443
      2096
      10443
      19216
      53317
    ];
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
  };
}
