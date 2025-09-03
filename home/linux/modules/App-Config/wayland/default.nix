{ ... }:
let
  importList =
    let
      content = builtins.readDir ./.;
      dirContent = builtins.filter (n: content.${n} == "directory") (builtins.attrNames content);
    in
    map (name: ./. + "/${name}") dirContent;
in
{
  imports = importList;
}
