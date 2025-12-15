let
  configPath = ./config;
  regularSearchEngines =
    let
      files = builtins.attrNames (builtins.readDir configPath);
    in
    builtins.foldl' (
      emptySet: searchEngine: emptySet // (import (configPath + "/${searchEngine}"))
    ) { } (builtins.filter (name: builtins.match ".*\\.nix$" name != null) files);
in
{
  search = {
    force = true;
    default = "Kagi";
    engines = regularSearchEngines;
    order = [
      "AlternativeTo"
      "Brave"
      "Core Radio"
      "Hackage"
      "Hoogle"
      "Jellyfin"
      "Nix Home Manager"
      "Nix Options"
      "Nix Packages"
      "Nix Wiki"
      "PeerTube"
      "SearXNG"
      "Sci-Hub"
      "Torrent Leech"
      "Urban Dictionary"
      "Wikipedia"
      "Youtube"
    ];
  };
}
