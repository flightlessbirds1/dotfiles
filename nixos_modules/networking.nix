{
  config,
  lib,
  pkgs,
  ...
}: {
  networking = {
    useNetworkd = true;
    dhcpcd.enable = false;
    networkmanager.enable = true;

    wireless.iwd = {
      enable = false;
      #   settings = {
      #     General = {
      #       EnableNetworkConfiguration = true; # iwd writes .network files & does DHCP
      #       Country = "US";
      #       AddressRandomization = "default"; # keep default while debugging
      #     };
      #     Network = {
      #       NameResolvingService = "systemd";
      #       EnableIPv6 = true;
      #     };
      #     # IMPORTANT: leave out Security/Scan/BSS customizations for stability
      #   };
    };
  };

  # systemd-resolved for DNS
  services.resolved = {
    enable = true;
    # minimal, let DHCP supply DNS; you can keep fallback if you like
    fallbackDns = ["1.1.1.1" "1.0.0.1" "2606:4700:4700::1111" "2606:4700:4700::1001"];
    dnssec = "allow-downgrade";
  };

  systemd.network.enable = true;

  systemd.network.wait-online.enable = false;

  environment.systemPackages = with pkgs; [iw iwgtk];
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [22 443 19216 53317];
    allowedUDPPorts = [19216 53317];
  };
}
