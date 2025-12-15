{ lib, ... }:
{
  flake.discoverModules =
    let
      isDirectory = type: type == "directory";
      isNixFile = name: type: type == "regular" && lib.hasSuffix ".nix" name && name != "default.nix";
    in
    basePath:
    let
      exploreDirectory =
        dirPath: dirName:
        let
          entries = builtins.readDir dirPath;
          directoryMeta = {
            inherit dirName dirPath subdirNames;
            hasDefault = entries ? "default.nix";
            hasNM = entries ? "nonmodule";
            nixFiles = lib.pipe entries [
              (lib.filterAttrs isNixFile)
              lib.attrNames
              (map (name: dirPath + ("/" + name)))
            ];
          };
          subdirMetas =
            if directoryMeta.hasNM then
              [ ]
            else
              lib.pipe entries [
                (lib.filterAttrs (_: isDirectory))
                (lib.mapAttrsToList (name: _: exploreDirectory (dirPath + ("/" + name)) name))
                lib.flatten
                (builtins.filter (subdirMeta: !subdirMeta.hasNM))
              ];
          subdirNames = map (x: x.dirName) subdirMetas;
        in
        subdirMetas ++ [ directoryMeta ];
      createModuleHierarchy = lib.foldl (
        acc: meta:
        let
          subModules = map (name: acc.${name}) meta.subdirNames;
          baseImport = lib.optionals meta.hasDefault [
            meta.dirPath
          ];
          nixFileImports = meta.nixFiles or [ ];
          allImports = baseImport ++ nixFileImports ++ subModules;
        in
        if meta.hasNM then
          acc
        else
          acc
          // {
            ${meta.dirName} = {
              imports = allImports;
            };
          }
      ) { };
    in
    lib.pipe basePath [
      builtins.readDir
      (lib.filterAttrs (_: isDirectory))
      (lib.mapAttrsToList (name: _: exploreDirectory (basePath + ("/" + name)) name))
      lib.flatten
      createModuleHierarchy
    ];
}
