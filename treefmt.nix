{pkgs, ...}: {
  projectRootFile = "flake.nix";

  programs.alejandra = {
    enable = true;
    package = pkgs.alejandra;
  };

  settings.formatter.alejandra = {
    includes = ["*.nix"];
  };
}
