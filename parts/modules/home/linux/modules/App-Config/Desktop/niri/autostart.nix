{
  pkgs,
  hostname,
  ...
}:
{
  home.packages = [
    pkgs.swaybg
  ];

  programs.niri.settings = {
    spawn-at-startup = [
      {
        command = [
          "firefox"
        ];
      }
      {
        command = [
          "vicinae"
          "server"
        ];
      }
    ]
    ++ (
      if hostname == "laptop" then
        [
        ]
      else
        [
          {
            command = [
              "vesktop"
            ];
          }
          {
            command = [
              "spotify"
            ];
          }
          {
            command = [
              "xwayland-satellite"
            ];
          }

          {
            command = [
              "swaync"
            ];
          }
        ]
    );
    hotkey-overlay.skip-at-startup = true;
  };
}
