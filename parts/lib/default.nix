{
  inputs,
  config,
  ...
}:
{
  flake.lib =
    let
      inherit (inputs.nixpkgs) lib;
      inherit (inputs.self) systemConfigurations;
    in
    rec {
      systems = {
        mkLinuxSystem =
          hostname: username: system: stateVersion: additional_modules: features:
          lib.nixosSystem {
            modules = additional_modules ++ [
              systemConfigurations.shared
            ];

            inherit
              system
              ;

            specialArgs = {
              inherit
                inputs
                stateVersion
                system
                hostname
                username
                ;

              pkgs-stable = import inputs.nixpkgs-stable {
                inherit system;
                config.allowUnfree = true;
              };
              flake = {
                inherit
                  config
                  ;
                inherit (inputs) self;
              };

              flake_lib = inputs.self.lib;

              features = features // {
                darwin = false;
              };
            };
          };

        mkPortableLinuxSystem =
          system: stateVersion: additional_modules:
          systems.mkLinuxSystem "nixos" system stateVersion additional_modules {
            darwin = false;
            sops = false;
          };

        mkDarwinSystem =
          hostname: username: system: stateVersion: additional_modules:
          inputs.nix-darwin.lib.darwinSystem {
            modules = additional_modules ++ [
              (import ../systems/mbp)
            ];

            specialArgs = {
              inherit
                inputs
                stateVersion
                system
                hostname
                username
                ;
              flake = {
                inherit
                  config
                  ;
              };

              features = {
                darwin = false;
              };
            };
          };
      };

      options = {
        mkUsersOption =
          description:
          let
            user_type = lib.types.submodule {
              options = {
                enable = lib.mkEnableOption description;
              };
            };
          in
          {
            users = lib.mkOption {
              type = lib.types.attrsOf user_type;
              default = { };
            };
            enable = lib.mkEnableOption description;
          };

        mkUsersAssertions =
          name: usernames:
          {
            config,
            lib,
            ...
          }:
          {
            assertions = lib.attrsets.mapAttrsToList (username: _val: {
              assertion = lib.attrsets.hasAttrByPath [ username ] config.users.users;
              message = "${name} - \"${username}\" must be present in users.users";
            }) usernames;
          };

        mkHomeManagerUsersAssertions =
          name: usernames:
          {
            config,
            lib,
            ...
          }:
          {
            assertions = lib.attrsets.mapAttrsToList (username: _val: {
              assertion =
                lib.attrsets.hasAttrByPath [ username ] config.users.users
                && lib.attrsets.hasAttrByPath [ username ] config.home-manager.users;
              message = "${name} - \"${username}\" must be present in users.users and home-manager.users";
            }) usernames;
          };
      };

      modules = {
        # Generates a configurable module that does something per-user.
        # generate_config is a function that accepts two arguments, cfg and mkAllUserConfig,
        # which should be called for every option set under config
        # with a function that takes in a username and returns config.
        # E.x.
        # mkPerUserModule ["example"] "example" config (cfg: mkAllUserConfig: {
        #     users.users = mkAllUserConfig (username: {
        #         "${username}" = {
        #             extraGroups = ["example"];
        #         };
        #     })
        # })
        mkPerUserModule =
          {
            option_path,
            description,
            imports ? [ ],
            config,
            generate_config ? (_x: _y: { }),
            ...
          }:
          let
            cfg = lib.attrsets.attrByPath option_path { } config;
            mkAllUserConfig =
              mkPerUserConfig:
              (lib.mkIf cfg.enable (
                lib.mkMerge (lib.attrsets.mapAttrsToList (username: _val: mkPerUserConfig username) cfg.users)
              ));
          in
          {
            imports = [
              (options.mkUsersAssertions (lib.strings.concatStringSep "." option_path) cfg.users)
            ]
            ++ imports;

            options = lib.attrsets.setAttrByPath option_path (options.mkUsersOption description);

            config = generate_config cfg mkAllUserConfig;
          };

        mkDualModule =
          {
            option_path,
            description,
            imports ? [ ],
            additional_options ? { },
            home_manager_imports ? { },
            config,
            generate_config ? (_x: _y: { }),
            ...
          }:
          let
            cfg = lib.attrsets.attrByPath option_path { } config;
          in
          modules.mkPerUserModule {
            inherit option_path description config;
            imports = imports ++ [
              (options.mkHomeManagerUsersAssertions (lib.strings.concatStringSep "." option_path) cfg.users)
              additional_options
            ];
            generate_config =
              _cfg: mkAllUserConfig:
              (generate_config cfg mkAllUserConfig)
              // {
                home-manager.users = mkAllUserConfig (username: {
                  "${username}" = lib.mkIf cfg.users.${username}.enable { imports = home_manager_imports; };
                });
              };
          };

        mkSimpleDualModule =
          {
            option_path,
            description,
            config,
            nixos_imports,
            home_manager_imports,
            ...
          }:
          modules.mkDualModule {
            inherit
              option_path
              description
              config
              home_manager_imports
              ;
            imports = nixos_imports;
          };
      };
    };
}
