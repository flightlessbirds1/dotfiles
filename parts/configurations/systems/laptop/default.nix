{
  pkgs,
  flake,
  ...
}: {
  imports = with flake.self.nixosModules; [
    ./hardware-configuration.nix
    laptop
    users
  ];

  environment.systemPackages = with pkgs; [];
}
