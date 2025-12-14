{ self, ... }:
let
  stateVersion = "26.05";
  username = "insomniac";
in
{
  flake.nixosConfigurations =
    let
      inherit (self) systemConfigurations;
    in
    {
      desktop =
        let
          system = "x86_64-linux";
          hostname = "desktop";
        in
        self.lib.systems.mkLinuxSystem hostname username system stateVersion
          [
            systemConfigurations.desktop
          ]
          {
            asahi = false;
            sops = true;
          };

      laptop =
        let
          system = "x86_64-linux";
          hostname = "laptop";
        in
        self.lib.systems.mkLinuxSystem hostname username system stateVersion
          [
            systemConfigurations.laptop
          ]
          {
            asahi = false;
            sops = true;
          };
    };
}
