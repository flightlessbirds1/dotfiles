{
  config,
  username,
  hostname,
  ...
}: let
  helper = import ../lib/Helper-Functions/System-dependent-checker.nix;
in {
  networking.wg-quick.interfaces = {
    Proton-NL = helper.system-dependent-checker {
      inherit username hostname;
      concatenation_type = "attrbute";
      portable_content = {
        address = [
          "10.2.0.2/32"
        ];
        dns = [
          "10.2.0.1"
        ];
        privateKeyFile = config.sops.secrets.proton-private.path;

        peers = [
          {
            publicKey = "afmlPt2O8Y+u4ykaOpMoO6q1JkbArZsaoFcpNXudXCg=";
            allowedIPs = [
              "0.0.0.0/0,::/0"
            ];
            endpoint = "46.29.25.3:51820";
            persistentKeepalive = 25;
          }
        ];
      };
      desktop_content = {
        autostart = true;
      };
      laptop_content = {
        autostart = false;
      };
      backup_content = {
        autostart = false;
      };
    };
  };
}
