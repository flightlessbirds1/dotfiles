{ lib, ... }:
let
  aestheticsSubmodule = lib.types.submodule {
    options = {
      currentTheme = lib.mkOption {
        type = lib.types.str;
      };
      font = lib.mkOption {
        type = lib.types.str;
      };
      themes = lib.mkOption {
        type = lib.types.attrsOf themesSubmodule;
      };
    };
  };
  themesSubmodule = lib.types.submodule {
    options = {
      colors = lib.mkOption {
        type = lib.types.attrsOf lib.types.str;
      };
    };
  };
in
{
  options.aesthetics = lib.mkOption { type = aestheticsSubmodule; };

  config.aesthetics = import ./colors.nix;
}
