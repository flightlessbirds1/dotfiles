{ config, ... }:
{
  networking.wg-quick.interfaces = {
    Proton-NL = {
      address = [
        "10.2.0.2/32"
      ];
      dns = [
        "9.9.9.9"
      ];
      privateKeyFile = config.sops.secrets.proton-NL.path;

      peers = [
        {
          publicKey = "UVfbp8djPv9nFWw54zPaMFe6fBoy2GzveLRsPngiPlc=";
          allowedIPs = [
            "0.0.0.0/0, ::/0"
          ];
          endpoint = "89.222.103.5:51820";
          persistentKeepalive = 25;
        }
      ];
      autostart = false;
    };
  };
}
