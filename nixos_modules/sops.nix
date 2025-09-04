{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  imports = [
    inputs.sops-nix.nixosModules.default
  ];
  sops.age.sshKeyPaths = [
    "/etc/ssh/ssh_host_ed25519_key"
  ];
  sops.age.keyFile = "/var/lib/sops-nix/key.txt";
  sops.age.generateKey = true;

  # Your existing secrets
  sops.secrets.password = {
    format = "binary";
    sopsFile = ../secrets/password.txt;
    neededForUsers = true;
  };
  sops.secrets.preshared = {
    format = "binary";
    sopsFile = ../secrets/preshared-key.txt;
  };
  sops.secrets.private = {
    format = "binary";
    sopsFile = ../secrets/private-key.txt;
  };
  sops.secrets.weather_location = {
    sopsFile = ../secrets/weather-location.yaml;
  };

  # Add weather API key secret
  sops.secrets.weather_api_key = {
    sopsFile = ../secrets/weather-api-key.yaml;
  };
  sops.secrets.proton-private = {
    sopsFile = ../secrets/proton-private-key.yaml;
  };

  # Export both weather secrets to environment
  systemd.services.export-weather-secrets = {
    description = "Export weather secrets to environment file";
    wantedBy = [
      "multi-user.target"
    ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.writeShellScript "export-weather-secrets" ''
        mkdir -p /etc/environment.d
        echo "WEATHER_LOCATION=$(cat ${config.sops.secrets.weather_location.path})" > /etc/environment.d/50-weather-secrets.conf
        echo "WEATHER_API_KEY=$(cat ${config.sops.secrets.weather_api_key.path})" >> /etc/environment.d/50-weather-secrets.conf
      ''}";
    };
  };
}
