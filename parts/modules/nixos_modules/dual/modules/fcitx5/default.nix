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
    "fcitx5"
  ];
  description = "Enable fcitx5 with support for English, Spanish, and Chinese input methods and logic quick phrases";

  nixos_imports = [./nixos];
  home_manager_imports = with flake.self.homeManagerModules; [fcitx5];
}
