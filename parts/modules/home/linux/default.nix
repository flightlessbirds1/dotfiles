{
  inputs,
  config,
  features,
  hostname,
  username,
  flake,
  pkgs-stable,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager.backupFileExtension = "homemanagerbackup";

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.extraSpecialArgs = {
    weatherSecretPath = config.sops.secrets.weather_location.path;
    weatherApiKeyPath = config.sops.secrets.weather_api_key.path;
    inherit
      inputs
      features
      hostname
      username
      flake
      pkgs-stable
      ;
  };
}
