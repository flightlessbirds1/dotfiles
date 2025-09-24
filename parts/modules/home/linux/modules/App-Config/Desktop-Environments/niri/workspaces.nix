{osConfig, ...}: {
  programs.niri.settings.workspaces = {
    "01-terminal" = {
      open-on-output =
        if osConfig.networking.hostName == "laptop"
        then null
        else "DP-1";
    };

    "02-web" = {
      open-on-output =
        if osConfig.networking.hostName == "laptop"
        then null
        else "DP-2";
    };

    "03-code" = {
      open-on-output =
        if osConfig.networking.hostName == "laptop"
        then null
        else "DP-1";
    };

    "04-music" = {
      open-on-output =
        if osConfig.networking.hostName == "laptop"
        then null
        else "DP-1";
    };

    "05-chat" = {
      open-on-output =
        if osConfig.networking.hostName == "laptop"
        then null
        else "DP-2";
    };

    "06-files" = {
      open-on-output =
        if osConfig.networking.hostName == "laptop"
        then null
        else "DP-1";
    };

    "07-gaming" = {
      open-on-output =
        if osConfig.networking.hostName == "laptop"
        then null
        else "DP-2";
    };

    "08-misc" = {
      open-on-output =
        if osConfig.networking.hostName == "laptop"
        then null
        else "DP-1";
    };
  };
}
