{config, ...}: {
  networking.wg-quick.interfaces = {
    proton-uk = {
      address = [
        "10.2.0.2/32"
      ];
      dns = [
        "10.2.0.1"
      ];
      privateKeyFile = config.sops.secrets.private.path;

      peers = [
        {
          publicKey = "lMm8Gocz1SIU/eAhpBzPHIWvAxJ30Oyeaj2PvmNl/Qk=";
          allowedIPs = [
            "0.0.0.0/0, ::/0"
          ];
          endpoint = "146.70.204.178:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };
  networking.wg-quick.interfaces.proton-uk = {
    # Your existing configuration
    autostart = true;
  };
}
