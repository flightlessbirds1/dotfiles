{lib, ...}: let
  first-content = builtins.readDir ./.;
  get-names = content: builtins.attrNames content;
  first-filter = builtins.filter (names: first-content.${names} == "directory") (get-names first-content);
  second-content = builtins.map (names: builtins.readDir ./${names}) first-filter;
  content-to-attrset = lib.mergeAttrsList second-content;
  # get-names-2 = builtins.attrNames (builtins.listToAttrs second-filter);
in {
  imports = get-names;
}
