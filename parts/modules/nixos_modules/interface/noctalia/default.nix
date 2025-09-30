{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.noctalia.nixosModules.default
  ];
  services.noctalia-shell.enable = true;
  environment.systemPackages = with pkgs; [
    inputs.noctalia.packages.${system}.default
    kdePackages.qt6ct
  ];
}
