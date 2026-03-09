{
  "Brave" = {
    definedAliases = [
      "@br"
    ];
    icon = ./icons/br.png;
    urls = [
      { template = "https://search.brave.com/search?q={searchTerms}&source=web"; }
    ];
  };
  "Kagi" = {
    definedAliases = [
      "@ka"
    ];
    icon = ./icons/ka.png;
    urls = [
      { template = "https://kagi.com/search?q={searchTerms}"; }
    ];
  };
  "SearXNG" = {
    definedAliases = [
      "@se"
    ];
    icon = ./icons/searxng.png;
    urls = [
      {
        template = "https://kantan.cat/search?q={searchTerms}&category_general=1&language=auto&time_range=&safesearch=0&theme=simple";
      }
    ];
  };
  "StartPage" = {
    definedAliases = [
      "@sp"
    ];
    icon = ./icons/searxng.png;
    urls = [
      {
        template = "https://www.startpage.com/do/search?cat=web&language=english&lui=english&t=device&sc=SPAf5SssZnbK10&with_date=&qsr=all&qadf=none&query={searchTerms}";
      }
    ];
  };
}
