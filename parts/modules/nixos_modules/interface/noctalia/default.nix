{
  pkgs,
  inputs,
  flake,
  lib,
  system,
  ...
}: {
  imports = [
    inputs.noctalia.nixosModules.default
  ];

  environment.systemPackages =
    lib.mkIf (flake.config.environment == "noctalia")
    (builtins.attrValues {
      inherit
        (pkgs)
        ;
      noctalia = inputs.noctalia.packages.${system}.default;
      # inherit (pkgs.kdePackages)
      #   qt6ct
      #   ;
    });
}
