{
  inputs,
  pkgs,
  config,
  hostname,
  username,
  system,
  stateVersion,
  ...
}: let
  NM = ../../nixos_modules;
  users = ../../users;
in {
  imports = [
    ../shared/default.nix
    ./hardware-configuration.nix
    (users + /default_user.nix)
    (NM + /boot.nix)
    (NM + /networking.nix)
    (NM + /wg-quick-AP.nix)
    (NM + /wg-quick-DC.nix)
    (NM + /wg-quick-EU.nix)
    (NM + /wg-quick.nix)
    (NM + /wg-quick-NL.nix)
    (NM + /kernel-parameters.nix)
    (NM + /gpu-reset-service.nix)
  ];

  services.logind.killUserProcesses = true;
  environment.systemPackages = with pkgs; [
    # rustdesk
  ];
}
