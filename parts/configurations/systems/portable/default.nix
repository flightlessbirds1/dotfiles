_: let
  NM = ../../nixos_modules;
in {
  imports = [
    ../shared
    ./hardware-configuration.nix
    (NM + /boot.nix)
    ../../users/default_user.nix
  ];
}
