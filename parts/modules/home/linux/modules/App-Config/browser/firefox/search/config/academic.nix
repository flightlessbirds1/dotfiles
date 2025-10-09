{
  "Sci-Hub" = {
    definedAliases = [
      "@sc"
    ];
    icon = ./icons/sc.png;
    urls = [
      {template = "https://sci-hub.ee/{searchTerms}";}
    ];
  };
  "Anna's Archive" = {
    definedAliases = [
      "@aa"
    ];
    icon = ./icons/aa.png;
    urls = [
      {template = "https://annas-archive.org/scidb/{searchTerms}";}
    ];
  };
  "Wikipedia" = {
    definedAliases = [
      "@wi"
    ];
    urls = [
      {template = "https://en.wikipedia.org/wiki/{searchTerms}";}
    ];
  };
  "Internet Encyclopedia of Philosophy" = {
    definedAliases = ["@iep"];
    icon = ./icons/internet-encyclopedia-of-philosophy.png;
    urls = [
      {
        template = "https://cse.google.com/cse?cx=001101905209118093242%3Arsrjvdp2op4&ie=UTF-8&q={searchTerms}&sa=Search";
      }
    ];
  };
  "Stanford Encyclopedia of Philosophy" = {
    definedAliases = [
      "@sep"
    ];
    icon = ./icons/ph.png;
    urls = [
      {template = "https://plato.stanford.edu/search/searcher.py?query={searchTerms}";}
    ];
  };
}
