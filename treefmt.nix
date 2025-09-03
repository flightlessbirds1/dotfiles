{
  projectRootFile = "flake.nix";
  programs.nixfmt.enable = true;
  settings.formatter = {
    nixfmt = {
      indentWidth = 2;
      includes = [ "*.nix" ];
    };
  };
}
