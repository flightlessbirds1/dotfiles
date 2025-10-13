{config, ...}: {
  networking.wg-quick.interfaces = {
    AirVPN-Phoenix = {
      address = [
        "10.158.41.80/32"
        "fd7d:76ee:e68f:a993:47f:d5ee:cb27:8280/128"
      ];
      dns = [
        "9.9.9.9"
      ];
      privateKeyFile = config.sops.secrets.private.path;

      peers = [
        {
          publicKey = "PyLCXAQT8KkM4T+dUsOQfn+Ub3pGxfGlxkIApuig+hk=";
          presharedKeyFile = config.sops.secrets.preshared.path;
          allowedIPs = [
            "0.0.0.0/0,::/0"
          ];
          endpoint = "198.44.133.86:1637";
          persistentKeepalive = 25;
        }
      ];
    };
  };
  networking.wg-quick.interfaces.AirVPN-Phoenix = {
    autostart = true;
  };
}
