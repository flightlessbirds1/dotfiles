{
  description = "Typst Environment";

  inputs = {
    devshell.url = "github:numtide/devshell";
    flake-root.url = "github:srid/flake-root";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    pre-commit-hooks-nix.url = "github:cachix/pre-commit-hooks.nix";
  };

  outputs = inputs @ {
    nixpkgs,
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        inputs.devshell.flakeModule
        inputs.flake-root.flakeModule
        inputs.pre-commit-hooks-nix.flakeModule
        ./parts
      ];

      systems = nixpkgs.lib.systems.flakeExposed;
    };
}
