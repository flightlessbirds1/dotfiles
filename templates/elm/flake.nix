{
  description = "Elm Environment";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11";
  };
  outputs = inputs @ {flake-parts, ...}: let
    system = "x86_64-linux";
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        ./parts
      ];
      systems = [
        system
      ];
      perSystem = {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
        };
        _module.args.pkgs-stable = import inputs.nixpkgs-stable {
          inherit system;
        };
      };
    };
}
