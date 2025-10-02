{
  pkgs,
  hostname,
  ...
}: {
  home.packages = [
    pkgs.swaybg
  ];

  programs.niri.settings = {
    spawn-at-startup =
      [
        {
          command = [
            "noctalia-shell"
          ];
        }
        {
          command = [
            "firefox"
          ];
        }
      ]
      ++ (
        if hostname == "laptop"
        then [
        ]
        else [
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
        ]
      );
    hotkey-overlay.skip-at-startup = true;
  };
}
