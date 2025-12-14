let
  configPath = ./config;
  filterFiles = name: builtins.match ".*\\.nix$" name != null;
  bookmarks =
    let
      files = builtins.attrNames (builtins.readDir configPath);
    in
    builtins.foldl' (
      emptyList: bookmarkFile: emptyList ++ [ (import (configPath + "/${bookmarkFile}")) ]
    ) [ ] (builtins.filter filterFiles files);
in
{
  bookmarks = {
    force = true;
    settings = bookmarks;
  };
}
