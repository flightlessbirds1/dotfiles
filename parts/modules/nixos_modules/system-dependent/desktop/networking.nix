{ pkgs, ... }:
{
  networking = {
    nameservers = [
      "194.242.2.9"
      "9.9.9.9"
      "1.1.1.1"
    ];
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
      # dns = lib.mkForce "none";
    };
    wireless.iwd = {
      enable = true;
      settings = {
        Network = {
          EnableIPv6 = true;
        };
        Settings = {
          AutoConnect = true;
        };
      };
    };

    firewall = {
      enable = true;
      checkReversePath = false;
    };
  };

  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      iw
      ;
  };
}
