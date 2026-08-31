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
          hasNM = entries ? "nonmodule";

          childResults = lib.pipe entries [
            (lib.filterAttrs (_: isDirectory))
            (lib.mapAttrsToList (name: _: exploreDirectory (dirPath + "/${name}") name))
          ];

          validChildSelves = builtins.filter (m: !m.hasNM) (map (r: r.self) childResults);

          directoryMeta = {
            inherit dirName dirPath;
            inherit hasNM;
            subdirNames = map (m: m.dirName) validChildSelves;
            hasDefault = entries ? "default.nix";
            nixFiles = lib.pipe entries [
              (lib.filterAttrs isNixFile)
              lib.attrNames
              (map (name: dirPath + "/${name}"))
            ];
          };

          allDescendants = lib.concatMap (r: r.all) childResults;
        in
        {
          self = directoryMeta;
          all = allDescendants ++ [ directoryMeta ];
        };

      createModuleHierarchy = lib.foldl (
        acc: meta:
        let
          subModules = map (name: acc.${name}) meta.subdirNames;
          baseImport = lib.optionals meta.hasDefault [ meta.dirPath ];
          allImports = baseImport ++ meta.nixFiles ++ subModules;
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
      (lib.mapAttrsToList (name: _: exploreDirectory (basePath + "/${name}") name))
      (lib.concatMap (r: r.all))
      createModuleHierarchy
    ];
}
