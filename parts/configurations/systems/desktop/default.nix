{
  inputs,
  pkgs,
  flake,
  ...
}:
{
  imports = with flake.self.nixosModules; [
    ./hardware-configuration.nix
    users
    desktop
    wireguard
  ];

  services.logind.settings.Login.killUserProcesses = true;
  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      # rustdesk
      ;
  };
}
