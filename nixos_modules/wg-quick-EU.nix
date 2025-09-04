{config, ...}: {
  networking.wg-quick.interfaces = {
    AirVPN-EU = {
      address = [
        "10.158.41.80/32"
        "fd7d:76ee:e68f:a993:47f:d5ee:cb27:8280/128"
      ];
      dns = [
        "10.128.0.1"
        "fd7d:76ee:e68f:a993::1"
      ];
      privateKeyFile = config.sops.secrets.private.path;

      peers = [
        {
          publicKey = "PyLCXAQT8KkM4T+dUsOQfn+Ub3pGxfGlxkIApuig+hk=";
          presharedKeyFile = config.sops.secrets.preshared.path;
          allowedIPs = [
            "0.0.0.0/0,::/0"
          ];
          endpoint = "europe3.vpn.airdns.org:1637";
          persistentKeepalive = 25;
        }
      ];
    };
  };
  networking.wg-quick.interfaces.AirVPN-EU = {
    # Your existing configuration
    autostart = false;
  };
}
