{
  pkgs,
  config,
  ...
}:
let
  vicEx =
    name:
    (config.lib.vicinae.mkExtension {
      name = name;
      src =
        pkgs.fetchFromGitHub {
          owner = "vicinaehq";
          repo = "extensions";
          rev = "5bb4310a993f18886e8e330c8af8091614b3049c";
          sha256 = "sha256-yCLUHt8D4QRIYgcNWkw14wC5mJ80AgAdRXMR5/h8zJk=";
        }
        + "/extensions/${name}";
    });
in
{
  programs.vicinae = {
    enable = true;
    extensions =
      (map vicEx [
        "bluetooth"
        "niri"
        "nix"
        "pulseaudio"
      ])
      ++ [
        # WRAPPER START: Parentheses ensure this is treated as a single package item
        ((config.lib.vicinae.mkExtension {
          name = "wifi-commander";
          src =
            pkgs.fetchFromGitHub {
              owner = "explosives79";
              repo = "extensions";
              rev = "aecd73b10cc9877c89582be29734d77fda7b95dd";
              sha256 = "sha256-MIl7NGrGixLXgevmFPDuSty1LBn3h382+viOMkowZI8=";
            }
            + "/extensions/wifi-commander";
        }).overrideAttrs (old: {
          preBuild = ''
            export HOME=$(pwd)
          '';
          installPhase = ''
            runHook preInstall
            
            mkdir -p $out
            cp -r .local/share/vicinae/extensions/${old.name or "wifi-commander"}/. $out/
            runHook postInstall
          '';
        }))
      ];

    systemd = {
      enable = true;
    };
  };
}
