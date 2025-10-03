shell: hostname: {
  programs.${shell}.shellAliases = {
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

    rbn =
      if shell == "fish"
      then ''begin; nix fmt . & find ~ -name "*.homemanagerbackup" -delete 2>/dev/null & wait; end; and nh os switch -H ${hostname} ~/Desktop/dotfiles''
      else ''nu -c "nix fmt .; ls ~/**/*.homemanagerbackup | each { rm $in }; nh os switch -H ${hostname} ~/Desktop/dotfiles"'';
    rbnl = (
      if shell == "fish"
      then ''begin; nix fmt .; find ~ -name "*.homemanagerbackup" | xargs rm; end; nixos-rebuild switch --sudo --flake .#laptop --cores 6 --max-jobs 4''
      else ''nu -c "nix fmt .; glob ~/**/*.homemanagerbackup | each { rm $in }; nixos-rebuild switch --sudo --flake .laptop --cores 6 --max-jobs 4"''
    );

    # ─── Cleanup ──────────────────────────────────────────────────────────────

    clean-a = "bash -c 'PATH=~/scripts:$PATH nh clean all'";
    clean-u = "bash -c 'PATH=~/scripts:$PATH nh clean user'";
    clean-d = "sudo nixos-collect-garbage -d";

    # ─── Utilities ────────────────────────────────────────────────────────────
    y = "yazi";
    ze = "zellij";
    lg = "lazygit";
  };
}
