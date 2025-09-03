{
  config,
  pkgs,
  lib,
  hostname,
  ...
}:

{
  home.packages = [ pkgs.swaybg ];

  programs.niri.settings = {
    spawn-at-startup = [
      {
        command = [ "swaync" ];
      }
      {
        command = [
          "spotify"
        ];
      }
      {
        command = [
          "vesktop"
        ];
      }
      {
        command = [
          "firefox"
        ];
      }
      {
        command = [
          "xwayland-satellite"
        ];
      }
    ]
    ++ (
      if hostname == "desktop" then
        [
          {
            command = [
              "nu"
              "-c"
              "eww open monitorBar1; eww open monitorBar2"
            ];
          }
        ]
      else
        [
          {
            command = [
              "eww"
              "open"
              "monitorBar"
            ];
          }
        ]
    );
    hotkey-overlay.skip-at-startup = true;
  };
}
