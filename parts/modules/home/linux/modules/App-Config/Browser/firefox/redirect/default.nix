{
  stdenv,
  redirect_id,
  ...
}:
let
  addon_id = redirect_id;
in
stdenv.mkDerivation rec {
  pname = "redirect-firefox-extension";
  version = "0.0.2";
  src = ./redirect.xpi;
  preferLocalBuild = true;
  allowSubstitutes = true;
  passthru = {
    addonId = addon_id;
  };
  buildCommand = ''
    dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
    mkdir -p "$dst"
    install -v -m644 "$src" "$dst/${addon_id}.xpi"
  '';
}
