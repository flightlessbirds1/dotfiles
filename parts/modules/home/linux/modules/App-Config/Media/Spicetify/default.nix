{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  programs.spicetify =
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      enable = true;

      enabledExtensions = with spicePkgs.extensions; [
        adblock
        hidePodcasts
        shuffle
        lastfm
        allOfArtist
        bestMoment
        queueTime
      ];
      enabledCustomApps = with spicePkgs.apps; [
        newReleases
        ncsVisualizer
      ];

      # theme = spicePkgs.themes.hazy;
      colorScheme = "custom";
      customColorScheme = {
        # Text
        text = "f8f8f8";
        subtext = "c0c0c0";

        # Backgrounds — all AMOLED black
        main = "000000";
        sidebar = "000000";
        player = "000000";
        card = "000000";
        shadow = "000000";
        misc = "000000";

        # Accent / highlights
        sidebar-text = "79dac8";
        selected-row = "1db954";
        button = "74b2ff";
        button-active = "74b2ff";
        button-disabled = "555555";
        tab-active = "74b2ff";
        notification = "74b2ff";
        notification-error = "e2637f";
      };
    };
}
