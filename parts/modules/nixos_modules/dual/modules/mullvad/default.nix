{
  config,
  flake,
  ...
}:
flake.self.lib.modules.mkSimpleDualModule {
  inherit config;

  option_path = [
    "dual_modules"
    "modules"
    "mullvad"
  ];
  description = "Enable Mullvad";

  nixos_imports = [ ./nixos.nix ];
  home_manager_imports = with flake.self.homeManagerModules; [ mullvad ];
}
