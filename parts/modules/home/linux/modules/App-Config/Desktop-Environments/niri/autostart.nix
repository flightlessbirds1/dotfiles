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
            "swaync"
          ];
        }
        {
          command = [
            "spotify"
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
        if hostname == "laptop"
        then [
        ]
        else [
          {
            command = [
              "vesktop"
            ];
          }
        ]
      );
    hotkey-overlay.skip-at-startup = true;
  };
}
