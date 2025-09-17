<<<<<<< HEAD
{lib, ...}: let
  importList = let
    first-content = builtins.readDir ./.;
    get-names = content: builtins.attrNames content;
    first-filter = builtins.filter (names: first-content.${names} == "directory") (get-names first-content);
    second-filter =
      builtins.filter (
        name: let
          dirContents = builtins.readDir ./${name};
        in
          !(builtins.hasAttr "non-module" dirContents)
      )
      first-filter;
  in
    map (name: ./. + "/${name}") second-filter;
in {
  imports = importList;
  importer = import ./importer;
  system-checker = import ./system-checker;
  system-dependent-checker = import ./system-dependent-checker;
=======
{
  importer = import ./module-importer.nix;
  checker = import ./System-Checker.nix;
  dependent-checker = import ./System-dependent-checker.nix;
>>>>>>> 7748cae (I actually added it on my laptop)
}
