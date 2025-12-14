{
  lib,
  pkgs,
  config,
  username,
  ...
}:
{
  programs.nh = {
    enable = true;
    flake = "${config.users.users.${username}.home}/Desktop/dotfiles";
  };

  nix = {
    settings = {
      max-jobs = "auto";
      cores = 0; # Use all cores per job
      keep-outputs = true;
      keep-derivations = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
      auto-optimise-store = true;
      builders-use-substitutes = true;
      min-free = lib.mkDefault (1024 * 1024 * 1024);
      max-free = lib.mkDefault (5 * 1024 * 1024 * 1024);
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      nh
      nvd # for nix-diff style comparisons
      ;
  };
}
