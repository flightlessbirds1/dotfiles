{self, ...}: {
  flake.nixosModules = self.discoverModules ./modules/nixos_modules;
}
