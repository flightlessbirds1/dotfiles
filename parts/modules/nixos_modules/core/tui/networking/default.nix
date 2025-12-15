{ pkgs, lib, ... }:
{
  networking = {
    useNetworkd = true;
    dhcpcd.enable = false;
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
      "8.8.8.8"
    ];
    networkmanager = {
      enable = true;
      dns = lib.mkForce "none";
    };
    wireless.iwd = {
      enable = false;
    };
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        80
        443
        2096
        8443
        9443
        19132
        19216
        25565
        53317
      ];
      allowedUDPPorts = [
        443
        2096
        10443
        19132
        19216
        25565
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
  };
  
  systemd.network = {
    enable = true;
    wait-online.enable = false;
    networks."10-ethernet" = {
      matchConfig.Name = "enp5s0";
      networkConfig = {
        DHCP = "yes";
        DNS = [ "1.1.1.1" "1.0.0.1" "8.8.8.8" ];
      };
      dhcpV4Config = {
        UseDNS = false;  
      };
      dhcpV6Config = {
        UseDNS = false;
      };
    };
    networks."20-wifi" = {
      matchConfig.Name = "wlp6s0";
      networkConfig = {
        DHCP = "yes";
        DNS = [ "1.1.1.1" "1.0.0.1" "8.8.8.8" ];
      };
      dhcpV4Config = {
        UseDNS = false;
      };
      dhcpV6Config = {
        UseDNS = false;
      };
    };
  };
  
  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      iw
      iwgtk
      ;
  };
}
