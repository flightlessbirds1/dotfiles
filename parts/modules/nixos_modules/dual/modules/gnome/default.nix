{
  pkgs,
  lib,
  config,
  flake,
  ...
}:
flake.self.lib.modules.mkSimpleDualModule {
  inherit config;

  option_path = [
    "dual_modules"
    "modules"
    "gnome"
  ];
  description = "Enable GNOME desktop environment and login";

  nixos_imports = [ ./nixos ];
  home_manager_imports = with flake.self.homeManagerModules; [ gnome ];
}
