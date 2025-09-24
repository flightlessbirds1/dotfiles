_: let
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
}
