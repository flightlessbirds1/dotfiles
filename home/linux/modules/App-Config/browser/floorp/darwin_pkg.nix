{
  stdenv,
  lib,
  callPackage,
  fetchurl,
  undmg,
  writeText,
  cfg ? {},
  extraPolicies ? {},
}: let
  versionSpecific = {
    version = "124.0.2";
    sha256 = "0dhx2mdiw6y79bdhh6sshjj0w8xbn5m16s5gs0b1g5ggd69qjv7l";
  };
  enterprisePolicies = {
    policies =
      {
        DisableAppUpdate = true;
      }
      // extraPolicies;
  };
  policiesJson = writeText "policies.json" (builtins.toJSON enterprisePolicies);
in
  stdenv.mkDerivation rec {
    inherit
      (versionSpecific)
      version
      ;

    name = "firefox-app-${version}";

    pname = "Firefox";

    src = fetchurl {
      inherit
        (versionSpecific)
        sha256
        ;
      url =
        "https://download-installer.cdn.mozilla.net/pub/firefox/"
        + "releases/${version}/mac/en-US/Firefox%20${version}.dmg";
      name = "${name}.dmg";
    };

    buildInputs = [
      undmg
    ];

    # The dmg contains the app and a symlink, the default unpackPhase
    # tries to cd into the only directory produced so it fails.
    sourceRoot = ".";

    installPhase = ''
      mkdir -p $out/Applications
      mv ${pname}.app $out/Applications
      mkdir -p $out/bin
      ln -s $out/Applications/${pname}.app/Contents/MacOS/firefox $out/bin

      mkdir -p "$out/Applications/${pname}.app/Contents/Resources/distribution"

      POL_PATH="$out/Applications/${pname}.app/Contents/Resources/distribution/policies.json"
      rm -f "$POL_PATH"
      cat ${policiesJson} >> "$POL_PATH"
    '';

    meta = {
      description = "Mozilla Firefox, free web browser (binary package)";
      homepage = "http://www.mozilla.org/firefox/";
      license = {
        free = false;
        url = "http://www.mozilla.org/en-US/foundation/trademarks/policy/";
      };
      maintainers = with lib.maintainers; [
        toonn
      ];
      platforms = [
        "aarch64-darwin"
      ];
    };
  }
