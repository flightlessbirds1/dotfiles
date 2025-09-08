{
  inputs,
  config,
  lib,
  hostname,
  stateVersion,
  system,
  pkgs,
  username,
  ...
}: let
  helper =
    import
    ../lib/Helper-Functions/System-Checker.nix;
in {
  imports = [
    ../home/linux/default.nix
  ];
  users.users.${username} = helper.system-checker {
    inherit
      username
      hostname
      ;
    concatenation_type = "attribute";
    portable_content = {
      home = "/home/${username}";
      isNormalUser =
        true;
      extraGroups = [
        "networkManager"
        "wheel"
      ];
      shell =
        pkgs.nushell;
    };
    unportable_content = {
      hashedPasswordFile =
        config.sops.secrets.password.path;
    };
    backup_content = {
      initialPassword = "nixos";
    };
  };
  home-manager.users.${username} = {pkgs, ...}: let
    hs =
      ../home/linux/modules;
  in {
    imports = [
      ../home/linux/modules
      ../home/linux/modules/App-Config/browser/firefox
      ../home/linux/modules/App-Config/browser/brave
      ../home/linux/modules/App-Config/browser/floorp
    ];
    home = {
      inherit
        username
        stateVersion
        ;
      homeDirectory = "/home/${username}";
      packages = with pkgs; [
        discord
        neovim
        git
        vesktop
        bottles
        fastfetch
        lutris
        bitwarden-desktop
        telegram-desktop
        localsend
        pcsx2
        qbittorrent
        libreoffice
        discord-canary
        zotero
        plex-desktop
        rnote
        proxychains-ng
        scrcpy
        jq
        curl
        grim
        slurp
        wl-clipboard
        blueman
        nodePackages_latest.prettier
        calibre
        foliate
        kdePackages.kdenlive
        brightnessctl
        parsec-bin
        # rustdesk
        git-credential-manager
        pdfarranger
        tokei
        imagemagick
        gpick
        spotdl
        nomacs-qt6
        qview
        ffmpeg
        mediainfo
        xwayland-satellite
        anki
        btop
        ff2mpv-rust
      ];
    };
  };
  services = {
    flatpak = {
      enable =
        true;
    };
  };
}
