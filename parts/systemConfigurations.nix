{ self, ... }:
{
  flake.systemConfigurations = self.discoverModules ./configurations/systems;
}
