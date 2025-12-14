{
  "Nix Home Manager" = {
    definedAliases = [
      "@nh"
    ];
    icon = ./icons/nx.png;
    urls = [
      { template = "https://searchix.alanpearce.eu/options/home-manager/search?query={searchTerms}"; }
    ];
  };
  "Nix Options" = {
    definedAliases = [
      "@no"
    ];
    icon = ./icons/nx.png;
    urls = [
      {
        template = "https://search.nixos.org/options?channel=unstable&size=50&sort=relevance&type=packages&query={searchTerms}";
      }
    ];
  };
  "Nix Packages" = {
    definedAliases = [
      "@np"
    ];
    icon = ./icons/nx.png;
    urls = [
      {
        template = "https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={searchTerms}";
      }
    ];
  };
  "Nix Wiki" = {
    definedAliases = [
      "@nw"
    ];
    icon = ./icons/nx.png;
    urls = [
      { template = "https://nixos.wiki/index.php?search={searchTerms}"; }
    ];
  };
}
