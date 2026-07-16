{
  inputs,
  pkgs,
  ...
}:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in
{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  programs.spicetify = {
    enable = false;
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      hidePodcasts
      shuffle
      volumePercentage
    ];
    theme = {
      name = "Blackout";
      src = pkgs.fetchFromGitHub {
        owner = "spicetify";
        repo = "spicetify-themes/";
        rev = "a9ce22b3d3df303d994974b746c839c7d0907101";
        hash = "sha256-HQJrCB5kN8mE4yzC6Sc0Dh7mpttoAGIx3cvlNGnkPvc=";
      };
    };
    wayland = false;
    # windowManagerPatch = true;
  };
  home.packages = [ pkgs.spotify ];
}
