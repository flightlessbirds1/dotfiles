{
  description = "NixOS configuration flake";

  inputs = {
    vscoq = {
      url = "github:coq-community/vscoq/53bc95c6e57504e11c0f785915f24b1b02707f9f";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions/?dir=pkgs/firefox-addons";
    };
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zsh-titles = {
      url = "github:amyreese/zsh-titles";
      flake = false;
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-lts.url = "github:NixOS/nixpkgs";
    nixpkgs-23-11.url = "github:NixOS/nixpkgs/nixos-23.11";
    pre-commit-hooks-nix = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Commented out to use helix from nixpkgs cache instead
    # helix = {
    #   url = "github:helix-editor/helix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
    };
    ghostty = {
      url = "github:ghostty-org/ghostty";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };
    niri-flake = {
      url = "github:sodiboo/niri-flake";
    };
  };
  outputs =
    inputs@{
      self,
      flake-parts,
      nixpkgs,
      nixvim,
      treefmt-nix,
      ...
    }:
    let
      stateVersion = "25.11";
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.pre-commit-hooks-nix.flakeModule
        ./lib
        ./nixos_modules/haskeww
      ];
      systems = [ "x86_64-linux" ];

      flake =
        { config, ... }:
        let
          eachSystem =
            f: nixpkgs.lib.genAttrs [ "x86_64-linux" ] (system: f nixpkgs.legacyPackages.${system});
          # Eval the treefmt modules from ./treefmt.nix
          treefmtEval = eachSystem (pkgs: inputs.treefmt-nix.lib.evalModule pkgs ./treefmt.nix);
        in
        {
          # for `nix fmt`
          formatter = eachSystem (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);

          nixosConfigurations = {
            desktop =
              let
                system = "x86_64-linux";
              in
              self.lib.systems.mkLinuxSystem "desktop" "insomniac" system stateVersion [
              ] { };

            laptop =
              let
                system = "x86_64-linux";
              in
              self.lib.systems.mkLinuxSystem "laptop" "insomniac" system stateVersion [
              ] { };
            portable =
              let
                system = "x86_64-linux";
              in
              self.lib.systems.mkLinuxSystem "portable" "insomniac" system stateVersion [
              ] { };

          };
        };
    };
}
