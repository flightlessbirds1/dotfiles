{
  pkgs,
  inputs,
  flake,
  lib,
  ...
}: {
  imports = [
    inputs.noctalia.nixosModules.default
  ];

  environment.systemPackages =
    lib.mkIf (flake.config.environment == "noctalia")
    (with pkgs; [
      inputs.noctalia.packages.${system}.default
      # kdePackages.qt6ct
    ]);
}
