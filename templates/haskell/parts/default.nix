let
  configPath = ./config;

  devshellImports =
    let
      files = builtins.attrNames (builtins.readDir configPath);
    in
    map (name: configPath + "/${name}") (
      builtins.filter (name: builtins.match ".*\\.nix$" name != null) files
    );
in
{
  imports = devshellImports;
}
