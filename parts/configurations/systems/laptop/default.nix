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
  programs.nekoray = {
    enable = true;
    tunMode.enable = true;
  };
  # environment.systemPackages = builtins.attrValues {
  # inherit
  # (pkgs)
  # ;
  # };
}
