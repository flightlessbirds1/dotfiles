{
  pkgs,
  flake,
  ...
}: {
  imports = with flake.self.nixosModules; [
    ./hardware-configuration.nix
    users
    desktop
    wireguard
  ];

  services.logind.settings.Login.killUserProcesses = true;
  environment.systemPackages = with pkgs; [
    # rustdesk
  ];
}
