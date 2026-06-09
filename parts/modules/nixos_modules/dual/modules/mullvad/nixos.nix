{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.dual_modules.modules.mullvad;
in
{
  services.mullvad-vpn = lib.mkIf cfg.enable {
    enable = true;
    package = pkgs.mullvad-vpn;
  };

  networking.wireguard.enable = lib.mkIf cfg.enable true;

  # From https://haseebmajid.dev/posts/2023-06-20-til-how-to-declaratively-setup-mullvad-with-nixos/
  systemd.services.mullvad-daemon.postStart =
    let
      mullvad = config.services.mullvad-vpn.package;
      mullvad-bin = "${mullvad}/bin/mullvad";
    in
    lib.mkIf cfg.enable ''
      while ! ${mullvad-bin} status >/dev/null; do sleep 1; done
      ${mullvad-bin} auto-connect set on
      ${mullvad-bin} dns set custom 2a07:a8c0::bf:2a16
      ${mullvad-bin} dns set custom 2a07:a8c1::bf:2a16
      ${mullvad-bin} lockdown-mode set on
      ${mullvad-bin} tunnel set ipv6 on
    '';
}
