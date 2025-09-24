{config, ...}: {
  networking.wg-quick.interfaces = {
    Proton-CA = {
      address = [
        "10.2.0.2/32"
      ];
      dns = [
        "10.2.0.1"
      ];
      privateKeyFile = config.sops.secrets.proton-private-key-CA.path;

      peers = [
        {
          publicKey = "XvDCw1FTglmXwAGfXCBPwdYXFz6BFuH6fe4kQTepXhY=";
          allowedIPs = [
            "0.0.0.0/0,::/0"
          ];
          endpoint = "149.102.228.57:51820";
          persistentKeepalive = 25;
        }
      ];
      autostart = false;
    };
  };
}
