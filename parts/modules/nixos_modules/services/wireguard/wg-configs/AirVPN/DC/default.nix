{config, ...}: {
  networking.wg-quick.interfaces = {
    AirVPN-DC =
      {
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
            endpoint = "198.54.128.117:1637";
            persistentKeepalive = 10;
          }
        ];
      }
      // (
        if config.networking.hostName == "desktop"
        then {
          autostart = false;
        }
        else {
          autostart = false;
        }
      );
  };
}
