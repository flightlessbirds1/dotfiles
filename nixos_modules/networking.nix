{ lib, ... }:
{
  networking = {
    useNetworkd = true;
    dhcpcd.enable = false;

    networkmanager.enable = false;

    wireless.iwd = {
      enable = true;
      settings = {
        General.EnableNetworkConfiguration = true;
        Network.NameResolvingService = "systemd";
        Settings.AutoConnect = true;
        IPv6.Enabled = true;
      };
    };

    firewall = {
      allowedTCPPorts = [
        22
        443
        19216
        53317
      ];
      allowedUDPPorts = [
        19216
        53317
      ];
    };
  };

  services.resolved = {
    enable = true;
    fallbackDns = [
      "9.9.9.9"
      "149.112.112.9"
    ];
    domains = [ "~." ];
    dnsovertls = "opportunistic";
    dnssec = "allow-downgrade";
    extraConfig = ''
      DNS=9.9.9.10 149.112.112.10
      Cache=yes
      DNSStubListener=yes
    '';
  };

  systemd.network = {
    enable = true;
    networks."40-wlan" = {
      matchConfig.Name = "wlan*";
      networkConfig = {
        DHCP = "yes";
        IPv6PrivacyExtensions = "yes";
      };
      dhcpV4Config = {
        UseDNS = true;
      };
      dhcpV6Config = {
        UseDNS = true;
      };
    };
  };
}
