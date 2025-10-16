{
  description = "Lean 4 flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    flake-parts.url = "github:hercules-ci/flake-parts";
    lean4-nix.url = "github:lenianiva/lean4-nix";
  };

  outputs = inputs @ {
    nixpkgs,
    flake-parts,
    lean4-nix,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];

      perSystem = {
        system,
        pkgs,
        ...
      }: let
        bootstrap = (import "${lean4-nix}/manifests/v4.19.0.nix").bootstrap;
        overlay = lean4-nix.readToolchainFile ./lean-toolchain;
      in {
        _module.args.pkgs = import nixpkgs {
          inherit system;
          overlays = [overlay];
        };

        packages.default =
          (pkgs.lean.buildLeanPackage {
            name = "Main";
            roots = ["src/Main.lean"];
            src = pkgs.lib.cleanSource ./.;
          }).executable;

        devShells.default = pkgs.mkShell {
          packages = with pkgs.lean; [lean-all];
        };
      };
    };
}
