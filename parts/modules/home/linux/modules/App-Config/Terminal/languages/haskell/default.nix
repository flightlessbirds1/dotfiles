{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      stylish-haskell
      ;
    inherit
      (pkgs.haskellPackages)
      cabal-install
      haskell-language-server
      fourmolu
      cabal-fmt
      hlint
      cabal-gild
      ghc
      ;
  };
}
