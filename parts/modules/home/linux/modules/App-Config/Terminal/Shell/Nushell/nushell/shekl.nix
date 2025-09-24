{osConfig, ...}: {
  programs.nushell.shellAliases = {
    # ─── AirVPN ────────────────────────────────────────────────────────────────
    start-AA = "sudo systemctl start wg-quick-AirVPN-America.service";
    stop-AA = "sudo systemctl stop wg-quick-AirVPN-America.service";

    start-AP = "sudo systemctl start wg-quick-AirVPN-Phoenix.service";
    stop-AP = "sudo systemctl stop wg-quick-AirVPN-Phoenix.service";

    start-MI = "sudo systemctl start wg-quick-AirVPN-MI.service";
    stop-MI = "sudo systemctl stop wg-quick-AirVPN-MI.service";

    start-EU = "sudo systemctl start wg-quick-AirVPN-EU.service";
    stop-EU = "sudo systemctl stop wg-quick-AirVPN-EU.service";

    start-DC = "sudo systemctl start wg-quick-AirVPN-DC.service";
    stop-DC = "sudo systemctl stop wg-quick-AirVPN-DC.service";

    # ─── ProtonVPN ─────────────────────────────────────────────────────────────
    start-NL = "sudo systemctl start wg-quick-Proton-NL.service";
    stop-NL = "sudo systemctl stop wg-quick-Proton-NL.service";

    start-CA = "sudo systemctl start wg-quick-Proton-CA.service";
    stop-CA = "sudo systemctl stop wg-quick-Proton-CA.service";

    # ─── Nix Rebuild Shortcuts ────────────────────────────────────────────────
    # rb   = "nix fmt .; glob ~/**/*.homemanagerbackup | each { rm $in }; nixos-rebuild switch --use-remote-sudo --flake .#${osConfig.networking.hostName}";
    # rbn  = "zsh -c \"nix fmt . && find ~ -name '*.homemanagerbackup' -delete && nh os switch -H $(hostname) ~/Desktop/dotfiles\"";

    rbns = ''zsh -c "nix fmt && find ~ -name '*.homemanagerbackup' -delete && nh os switch -H $(hostname) ~/Desktop/dotfiles -v"'';
    rbnu = ''zsh -c "nix fmt && find ~ -name '*.homemanagerbackup' -delete && nh os switch -H $(hostname) ~/Desktop/dotfiles -u"'';

    rbn = ''nu -c "nix fmt .; glob ~/**/*.homemanagerbackup | each { rm $in }; nh os switch -H ${osConfig.networking.hostName} ~/Desktop/dotfiles"'';
    rbnl = ''nu -c "nix fmt .; glob ~/**/*.homemanagerbackup | each { rm $in }; nixos-rebuild switch --sudo --flake .#laptop --cores 6 --max-jobs 4"'';

    # ─── Cleanup ──────────────────────────────────────────────────────────────
    clean-a = "bash -c 'PATH=~/scripts:$PATH nh clean all'";
    clean-u = "bash -c 'PATH=~/scripts:$PATH nh clean user'";
    clean-d = "sudo nixos-collect-garbage -d";

    # ─── Utilities ────────────────────────────────────────────────────────────
    y = "yy";
    ze = "zellij";
    lg = "lazygit";
    plex = ''zsh -c "export QT_STYLE_OVERRIDE=default && plex-desktop"'';
  };
}
