{
  lib,
  pkgs,
  ...
}: {
  programs.nh = {
    enable = true;
    flake = "/home/insomniac/Desktop/dotfiles";
  };

  environment.variables = {
    SUDO = "doas";
    NIX_SSHOPTS = "";
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
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
        "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
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

  environment.systemPackages = with pkgs; [
    nh
    nix-output-monitor
    nvd # for nix-diff style comparisons
  ];
}
