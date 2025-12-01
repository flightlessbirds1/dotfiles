{pkgs, ...}: let
  peazip-with-unrar = pkgs.peazip.overrideAttrs (old: {
    buildInputs = old.buildInputs ++ [pkgs.unrar];
    installPhase =
      old.installPhase
      + ''
        mkdir -p $out/lib/peazip/plugins
        cp ${pkgs.unrar}/bin/unrar $out/lib/peazip/plugins/unrar
        chmod 755 $out/lib/peazip/plugins/unrar
      '';
  });
in {
  environment.systemPackages = [peazip-with-unrar];
}
