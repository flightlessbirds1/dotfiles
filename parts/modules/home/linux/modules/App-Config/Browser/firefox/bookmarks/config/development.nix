let
  gitlabTags = [
    "git"
    "gitlab"
  ];
  gitlabURL = "https://gitlab.com";
in
{
  name = "Development";
  toolbar = false;
  bookmarks = [
    {
      name = "Elm Packages";
      url = "https://package.elm-lang.org/packages";
      tags = [
        "elm"
        "packages"
      ];
      keyword = "Elm";
    }
    {
      name = "Elm Examples";
      url = "https://elm-lang.org/examples";
      tags = [
        "elm"
        "elm"
        "examples"
      ];
      keyword = "Elm";
    }
    {
      name = "Awesome Haskell";
      url = "https://github.com/krispo/awesome-haskell";
      tags = [
        "awesome"
        "haskell"
      ];
      keyword = "awesome";
    }
    {
      name = "Hackage";
      url = "https://hackage.haskell.org";
      tags = [
        "hackage"
        "hack"
        "haskell"
      ];
      keyword = "Hack";
    }
  ];
}
