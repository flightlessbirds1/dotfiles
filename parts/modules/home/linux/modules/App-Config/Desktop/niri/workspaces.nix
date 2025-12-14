{ osConfig, ... }:
{
  programs.niri.settings.workspaces = (
    if osConfig.networking.hostName == "desktop" then
      {
        "01-code" = {
          open-on-output = "DP-1";
        };

        "02-web" = {
          open-on-output = "DP-2";
        };

        "03-music" = {
          open-on-output = "DP-1";
        };

        "04-chat" = {
          open-on-output = "DP-1";
        };
      }
    else
      {
        "01-code" = {
          open-on-output = "eDP-1";
        };

        "02-web" = {
          open-on-output = "eDP-1";
        };
      }
  );
}
