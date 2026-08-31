let
  start = service: "sudo systemctl start wg-quick-${service}.service";
  stop = service: "sudo systemctl stop wg-quick-${service}.service";

  vpns = {
    AA = "AirVPN-America";
    AP = "AirVPN-Phoenix";
    DC = "AirVPN-DC";
    NC = "AirVPN-NC";
    NL = "Proton-NL";
    CA = "Proton-CA";
  };

  vpnAliases = builtins.listToAttrs (
    builtins.concatMap (abbrev: [
      {
        name = "start-${abbrev}";
        value = start vpns.${abbrev};
      }
      {
        name = "stop-${abbrev}";
        value = stop vpns.${abbrev};
      }
    ]) (builtins.attrNames vpns)
  );

in
shell: hostname:
let
  mkRebuild =
    cmd:
    if shell == "fish" then
      ''begin; nix fmt . & find ~ -name "*.homemanagerbackup" -delete 2>/dev/null & wait; end; and ${cmd}''
    else
      ''nu -c "nix fmt .; try { glob ~/**/*.homemanagerbackup | each { rm $in } }; ${cmd}"'';
in
{
  programs.${shell}.shellAliases = vpnAliases // {

    # ─── Nix Rebuild Shortcuts ────────────────────────────────────────────────
    rbn = mkRebuild "nh os switch -H ${hostname} ~/Desktop/dotfiles";
    rbnu = mkRebuild "nh os switch -u -H ${hostname} ~/Desktop/dotfiles";
    rbnl = mkRebuild "nixos-rebuild switch --sudo --flake .#laptop --cores 6 --max-jobs 4";

    # ─── Cleanup ──────────────────────────────────────────────────────────────
    clean-a = "nh clean all";
    clean-u = "nh clean user";
    clean-d = "sudo nixos-collect-garbage -d";

    # ─── Utilities ────────────────────────────────────────────────────────────
    ze = "zellij";
    lg = "lazygit";
  };
}
