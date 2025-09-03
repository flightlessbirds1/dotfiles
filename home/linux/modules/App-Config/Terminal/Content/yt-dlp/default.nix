{
  programs.yt-dlp =
    let
      configPath = ./config;
      extraConfigPath = import (configPath + /extraConfig.nix);
      settingsPath = import (configPath + /settings.nix);
    in
    {
      enable = true;
      extraConfig = extraConfigPath;
      settings = settingsPath;
    };
}
