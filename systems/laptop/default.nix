{
  inputs,
  pkgs,
  config,
  hostname,
  username,
  system,
  stateVersion,
  ...
}:
let
  NM = ../../nixos_modules;
in
{
  imports = [
    ./hardware-configuration.nix
    ../shared/default.nix
    (NM + /boot-laptop.nix)
    # (NM + /cpufreq.nix)
    # (NM + /networking-laptop.nix)
    ../../users/default_user.nix
    (NM + /battery.nix)

  ];

  environment.systemPackages = with pkgs; [
  ];
}
