{
  inputs,
  pkgs,
  flake,
  ...
}: {
  imports = with flake.self.nixosModules; [
    ./hardware-configuration.nix
    users
    desktop
    wireguard
    specializations
  ];

  specializations.plasma.enable = false;
  specializations.gaming.enable = false;
  specializations.compiling.enable = true;

  services.logind.settings.Login.killUserProcesses = true;
  environment.systemPackages = with pkgs; [
    # rustdesk
  ];
}
