{ pkgs, ... }:
{
  networking = {
    # nameservers = [
    #   "194.242.2.9"
    #   "9.9.9.9"
    #   "1.1.1.1"
    # ];
    networkmanager = {
      enable = true;
      # wifi.backend = "iwd";
      dns = "systemd-resolved";
    };
    # # wireless.iwd = {
    # #   enable = true;
    # #   settings = {
    # #     Network = {
    # #       EnableIPv6 = true;
    # #     };
    # #     Settings = {
    # #       AutoConnect = true;
    # #     };
    # #   };
    # };

    firewall = {
      enable = true;
      checkReversePath = false;
    };
  };

  services.resolved = {
    enable = true;
    settings.Resolve.DNS = [
      "2a07:a8c0::bf:2a16"
      "2a07:a8c1::bf:2a16"
      "45.90.28.42"
      "45.90.30.42"
    ];
  };

  networking.firewall = {
    allowedUDPPorts = [
      22
      53317
    ];
    allowedTCPPorts = [
      22
      53317
    ];
  };

  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      iw
      networkmanagerapplet
      ;
  };
}
