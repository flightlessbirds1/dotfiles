let
  gitlabTags = [
    "git"
    "gitlab"
  ];
  gitlabURL = "https://gitlab.com";
in {
  name = "Development";
  toolbar = false;
  bookmarks = [
    {
      name = "Discord (Development Portal)";
      url = "https://discord.com/developers/applications";
      tags = [
        "discord"
        "development"
        "portal"
        "bot"
      ];
      keyword = "Discord";
    }
    {
      name = "Civit";
      url = "https://civitai.com";
      tags = [
        "ui"
        "stable"
        "diffusion"
        "ai"
        "art"
        "generation"
      ];
      keyword = "Civit";
    }
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
      name = "Awesome Self-Hosted";
      url = "https://github.com/awesome-selfhosted/awesome-selfhosted";
      tags = [
        "awesome"
        "self-hosted"
        "self"
        "hosted"
      ];
      keyword = "Self";
    }
    {
      name = "GitHub";
      url = "https://github.com/BRBWaffles";
      tags = [
        "git"
        "github"
        "brbwaffles"
      ];
      keyword = "GitHub";
    }
    {
      name = "GitLab (Fallaryn)";
      url = "${gitlabURL}/fallaryn";
      tags =
        [
          "fallaryn"
        ]
        ++ gitlabTags;
      keyword = "GitLab";
    }
    {
      name = "GitLab (Isaac)";
      url = "${gitlabURL}/askyourself";
      tags =
        [
          "isaac"
          "askyourself"
        ]
        ++ gitlabTags;
      keyword = "GitLab";
    }
    {
      name = "GitLab (Nick)";
      url = "${gitlabURL}/upRootNutrition";
      tags =
        [
          "uprootnutrition"
        ]
        ++ gitlabTags;
      keyword = "GitLab";
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
    {
      name = "Elm-Land Server";
      url = "http://localhost:1234";
      tags = [
        "elm-land"
        "elm"
        "land"
      ];
      keyword = "Website";
    }
    {
      name = "Zenkit";
      url = "https://app.zenkit.com/home";
      tags = [
        "kanban"
        "zenkit"
        "zen"
        "kit"
      ];
      keyword = "Zen";
    }
    {
      name = "Namecheap";
      url = "https://www.namecheap.com";
      tags = [
        "namecheap"
        "name"
        "cheap"
        "dns"
      ];
      keyword = "Name";
    }
  ];
}
