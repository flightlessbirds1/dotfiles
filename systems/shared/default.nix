{
  inputs,
  pkgs,
  config,
  hostname,
  username,
  system,
  stateVersion,
  ...
}: let
  helper = import ../../lib/Helper-Functions/System-Checker.nix;
  NM = ../../nixos_modules;
in {
  imports =
    helper.system-checker
    {
      inherit hostname username;
      concatenation_type = "list";
      portable_content = [
        #    NM + /boot.nix
        (NM + /gnome.nix)
        (NM + /printing.nix)
        (NM + /sound.nix)
        (NM + /steam.nix)
        (NM + /electron_wayland.nix)
        (NM + /doas.nix)
        (NM + /fonts.nix)
        (NM + /xdg-portals.nix)
        # (NM + /hyprland.nix)
        # (NM + /cosmic.nix)
        (NM + /ramswap.nix)
        # (NM + /plasma.nix)
        (NM + /udev-rules.nix)
        (NM + /hyprland.nix)
        (NM + /networking.nix)
        (NM + /niri.nix)
        (NM + /i2c.nix)
        (NM + /wallet.nix)
        (NM + /documentation.nix)
        (NM + /timeout.nix)
        (NM + /cron.nix)
        (NM + /nh)
        (NM + /fans.nix)
      ];
      unportable_content = [
        (NM + /sops.nix)
        (NM + /wg-quick-AP.nix)
        (NM + /wg-quick-DC.nix)
        (NM + /wg-quick-EU.nix)
        (NM + /wg-quick.nix)
        (NM + /wg-quick-NL.nix)
      ];
      backup_content = [
      ];
    };

  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = "experimental-features = nix-command flakes";
    settings.allowed-users = [
      "@wheel"
    ];
  };

  system = {
    inherit
      stateVersion
      ;
  };

  nixpkgs.config.allowUnfree = true;

  networking.hostName = hostname;

  users.mutableUsers = false;

  users.users.root = {
    hashedPassword = "*";
  };

  environment.systemPackages = with pkgs; [
    neovim
    zsh
    wget
    tree
    p7zip
    kdePackages.ark
    peazip
    rar
    unrar
    obsidian
    wireguard-tools
    amberol
    nushell
    inputs.zen-browser.packages."${system}".default
    waybar
    dunst
    libnotify
    swww
    kitty
    stylish-haskell
    rofi
    sops
    nekoray
    nh
    claude-code
    waypaper
    waytrogen
    mpvpaper
    # Launcher
    fuzzel
    papirus-icon-theme
    # Screenshot-tools
    grim
    slurp
    wl-clipboard
    jq
    sway-contrib.grimshot
    pavucontrol
    ddcutil
    dysk
    bottom
    resources
    alejandra
    libinput
  ];

  programs.zsh.enable = false;
  users.defaultUserShell = pkgs.nushell;
  environment.shells = with pkgs; [
    nushell
  ];
}
