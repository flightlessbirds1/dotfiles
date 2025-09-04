{
  lib,
  pkgs,
  ...
}: {
  networking = {
    useNetworkd = true;
    dhcpcd.enable = false;
    networkmanager.enable = false;
    wireless.iwd = {
      enable = true;
      settings = {
        General = {
          EnableNetworkConfiguration = true;
          Country = "US";
          UseDefaultInterface = true;
          AddressRandomization = "once";
        };
        Network = {
          NameResolvingService = "systemd";
          EnableIPv6 = true;
          RoutePriorityOffset = 300;
        };
        Settings = {
          AutoConnect = true;
          DisableANQP = true;
          DisableRoamRetryLimit = true;
        };
        IPv6 = {
          Enabled = true;
        };
        Scan = {
          DisablePeriodicScan = true;
          InitialPeriodicScanInterval = 10;
          MaxPeriodicScanInterval = 300;
        };
        BSS = {
          RoamThreshold = -70;
          RoamThreshold5G = -76;
        };
        Security = {
          EAP-Method = "TTLS";
        };
      };
    };
    firewall = {
      enable = true;
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
      "1.1.1.1"
      "1.0.0.1"
      "2606:4700:4700::1111"
      "2606:4700:4700::1001"
    ];
    domains = [
      "~."
    ];
    dnsovertls = "opportunistic";
    dnssec = "allow-downgrade";
    extraConfig = ''
      DNS=1.1.1.1 1.0.0.1 2606:4700:4700::1111 2606:4700:4700::1001
      Cache=yes
      DNSStubListener=yes
      EDNS0=yes
      CacheFromLocalhost=no
      DNSStubListenerExtra=127.0.0.53
    '';
  };

  systemd.network = {
    enable = true;
    networks."40-wlan" = {
      matchConfig = {
        Name = "wlan*";
        Type = "wlan";
      };
      networkConfig = {
        DHCP = "yes";
        IPv6PrivacyExtensions = "yes";
        IPv6AcceptRA = true;
        ConfigureWithoutCarrier = true;
        KeepConfiguration = "yes";
        MulticastDNS = false;
        LLMNR = false;
        LinkLocalAddressing = "ipv6";
      };
      dhcpV4Config = {
        UseDNS = true;
        UseNTP = true;
        UseDomains = true;
        RapidCommit = true;
        MaxAttempts = 2;
        RequestTimeout = "10s";
        UseCachedLeaseTime = true;
      };
      dhcpV6Config = {
        UseDNS = true;
        UseNTP = true;
        UseDomains = true;
        RapidCommit = true;
        WithoutRA = "solicit";
        RequestTimeout = "10s";
      };
      ipv6AcceptRAConfig = {
        UseAutonomousPrefix = true;
        UseOnLinkPrefix = true;
        UseDNS = true;
        UseDomains = true;
        DHCPv6Client = "always";
      };
      linkConfig = {
        WakeOnLan = "off";
        GenericSegmentationOffload = true;
        TCPSegmentationOffload = true;
        TCP6SegmentationOffload = true;
        GenericReceiveOffload = true;
        LargeReceiveOffload = true;
        MTUBytes = "1500";
      };
    };
  };

  boot.kernel.sysctl = {
    "net.ipv6.conf.all.accept_ra" = 1;
    "net.ipv6.conf.all.accept_ra_defrtr" = 1;
    "net.ipv6.conf.all.accept_ra_pinfo" = 1;
    "net.ipv4.tcp_syn_retries" = 3;
    "net.ipv4.tcp_synack_retries" = 3;
    "net.ipv6.conf.all.dad_transmits" = 1;
  };

  systemd.network.wait-online = {
    enable = false;
  };

  environment.systemPackages = with pkgs; [
    iw
    iwgtk
  ];
}
