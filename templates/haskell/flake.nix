{
  inputs = {
    haskell-flake.url = "github:srid/haskell-flake";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    pre-commit-hooks-nix.url = "github:cachix/pre-commit-hooks.nix";
  };
  outputs =
    inputs@{
      nixpkgs,
      flake-parts,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.haskell-flake.flakeModule
        inputs.pre-commit-hooks-nix.flakeModule
        ./parts
      ];
      systems = nixpkgs.lib.systems.flakeExposed;
    };
}
