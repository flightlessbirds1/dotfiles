{self, ...}: {
  flake.homeManagerModules = self.discoverModules ./modules/home;
}
