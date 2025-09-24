{
  perSystem = {pkgs, ...}: let
    hp = pkgs.haskellPackages;
    haskeww = hp.callCabal2nix "haskeww" ./. {};
  in {
    devShells.haskeww = hp.shellFor {
      nativeBuildInputs = builtins.attrValues {
        inherit
          (pkgs)
          nil
          socat
          ;
        inherit
          (hp)
          cabal-install
          haskell-language-server
          ;
      };
      packages = _: [
        haskeww
      ];
    };
    packages = {
      inherit
        haskeww
        ;
    };
  };
}
