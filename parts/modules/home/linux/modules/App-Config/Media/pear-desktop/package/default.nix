{
  stdenv,
  fetchzip,
  makeWrapper,
  lib,
  autoPatchelfHook,
  alsa-lib,
  at-spi2-atk,
  at-spi2-core,
  cairo,
  cups,
  dbus,
  expat,
  libdrm,
  libxkbcommon,
  mesa,
  nspr,
  nss,
  pango,
  libGL,
  systemd,
  xorg,
  gtk3,
  glib,
  atk,
}:

stdenv.mkDerivation rec {
  pname = "pear-desktop";
  version = "3.11.0";

  src = fetchzip {
    url = "https://github.com/pear-devs/pear-desktop/releases/download/v3.11.0/youtube-music-3.11.0.tar.gz";
    sha256 = "sha256-0q0suLM4MoN59Hu8AjGR8aHFGYZtXuSoeVZiU0VevcY=";
  };

  nativeBuildInputs = [
    makeWrapper
    autoPatchelfHook
  ];

  buildInputs = [
    alsa-lib
    at-spi2-atk
    at-spi2-core
    atk
    cairo
    cups
    dbus
    expat
    glib
    gtk3
    libdrm
    libGL
    libxkbcommon
    mesa
    nspr
    nss
    pango
    systemd
    xorg.libX11
    xorg.libxcb
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXrandr
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/share/pear-desktop
    cp -r * $out/share/pear-desktop/

    makeWrapper $out/share/pear-desktop/youtube-music $out/bin/pear-desktop \
      --chdir $out/share/pear-desktop \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath buildInputs}"

    ln -s $out/bin/pear-desktop $out/bin/youtube-music

    runHook postInstall
  '';

  meta = with lib; {
    description = "YouTube Music desktop app";
    homepage = "https://github.com/pear-devs/pear-desktop";
    platforms = platforms.linux;
  };
}
