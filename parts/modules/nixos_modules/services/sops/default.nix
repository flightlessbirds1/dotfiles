{
  pkgs,
  inputs,
  config,
  flake,
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
  sops = {
    secrets = {
      password = {
        format = "binary";
        sopsFile = flake.self.secrets + /password.txt;
        neededForUsers = true;
      };
      proton-private-key-CA = {
        format = "binary";
        sopsFile = flake.self.secrets + /proton-private-key-CA.txt;
        neededForUsers = true;
      };
      preshared = {
        format = "binary";
        sopsFile = flake.self.secrets + /preshared-key.txt;
      };
      private = {
        format = "binary";
        sopsFile = flake.self.secrets + /private-key.txt;
      };
      weather_location = {
        sopsFile = flake.self.secrets + /weather-location.yaml;
      };
      weather_api_key = {
        sopsFile = flake.self.secrets + /weather-api-key.yaml;
      };
      proton-private = {
        sopsFile = flake.self.secrets + /proton-private-key.yaml;
      };
      location = {
        sopsFile = flake.self.secrets + /location.yaml;
        mode = "0400";
        owner = "insomniac";
      };
      proton-NL = {
        sopsFile = flake.self.secrets + /proton-NL.txt;
        format = "binary";
      };
      proton-FL = {
        sopsFile = flake.self.secrets + /proton-FL.txt;
        format = "binary";
      };
    };
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
  environment.systemPackages = builtins.attrValues {
    inherit
      (pkgs)
      sops
      ;
  };
}
