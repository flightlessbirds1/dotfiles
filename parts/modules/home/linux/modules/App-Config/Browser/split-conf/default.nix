{
  lib,
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    (import ../firefox/default.nix {
      browser = "firefox";
      inherit
        lib
        inputs
        config
        pkgs
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
        ;
    })
    ../zen
    ../brave
  ];
}
