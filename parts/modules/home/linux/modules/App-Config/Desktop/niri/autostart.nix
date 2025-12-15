{
  pkgs,
  hostname,
  flake,
  ...
}:
{
  home.packages = [
    pkgs.swaybg
  ];

  programs.niri.settings = {
    spawn-at-startup =
      [
        {
          command = [
            "${pkgs.gnome-keyring}/bin/gnome-keyring-daemon"
            "--start"
            "--components=secrets,ssh,pkcs11"
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
          {
            command = [
              "echo i2c-ELAN9008:00 | sudo tee /sys/bus/i2c/drivers/i2c_hid_acpi/unbind"
            ];
          }
        ]
      else
        [
          {
            command = [
              "equibop"
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
    )
    ++ (
      if flake.config.environment == "noctalia" then
        [
          {
            command = [
              "noctalia-shell"
            ];
          }
        ]
      else
        [
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
