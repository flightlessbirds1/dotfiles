{
  pkgs,
  lib,
  config,
  flake,
  ...
}: let
  cfg = config.dual_modules.users;
in {
  imports = [
    ./modules/fcitx5
  ];

  options = {
    dual_modules.users = let
      user_type = lib.types.submodule {
        options = {
          use = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [];
          };
        };
      };
    in
      lib.mkOption {
        type = lib.types.attrsOf user_type;
        default = {};
      };
  };

  config.dual_modules.modules = lib.mkMerge (
    lib.attrsets.mapAttrsToList (
      username: value:
        lib.mkMerge (
          builtins.map (name: {
            "${name}" = {
              users."${username}".enable = true;
            };
          })
          value.use
        )
    )
    cfg
  );
}
