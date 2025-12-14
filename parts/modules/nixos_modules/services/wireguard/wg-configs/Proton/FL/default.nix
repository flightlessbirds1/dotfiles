{ config, ... }:
{
  networking.wg-quick.interfaces = {
    Proton-FL = {
      address = [
        "10.2.0.2/32"
      ];
      dns = [
        "9.9.9.9"
      ];
      privateKeyFile = config.sops.secrets.proton-FL.path;

      peers = [
        {
          publicKey = "2nZkJr74LHqiPIAjDmdo1EJrN7DJLVq7N92RNYv7cSk=";
          allowedIPs = [
            "0.0.0.0/0, ::/0"
          ];
          endpoint = "37.221.112.194:51820";
          persistentKeepalive = 25;
        }
      ];
      autostart = false;
    };
  };
}
