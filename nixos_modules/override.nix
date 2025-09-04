{lib, ...}: {
  disabledModules = [
    "services/display-managers/cosmic-greeter.nix"
    "nixos/modules/services/display-managers/cosmic-greeter.nix"
    "cosmic-greeter/module.nix"
    "nixos/cosmic-greeter/module.nix"
  ];

  options.services.displayManager.cosmic-greeter.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Dummy option to prevent conflicts";
  };

  # Force any display manager settings to sane defaults
  config = {
    services.displayManager.cosmic-greeter.enable = lib.mkForce false;
    services.displayManager.gdm.enable = lib.mkForce true;
  };
}
