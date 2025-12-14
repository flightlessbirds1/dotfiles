{
  lib,
  inputs,
  config,
  pkgs,
  pkgs-stable,
  ...
}:
{
  imports = [
    (import ../firefox/default.nix {
      browser = "firefox";
      inherit
        lib
        inputs
        config
        pkgs
        pkgs-stable
        ;
    })
    (import ../firefox/default.nix {
      browser = "floorp";
      package = "floorp-bin";
      inherit
        lib
        inputs
        pkgs
        config
        pkgs-stable
        ;
    })
    ../zen
    ../brave
  ];
}
