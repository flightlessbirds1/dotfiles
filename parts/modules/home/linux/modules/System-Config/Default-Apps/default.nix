_: {
  xdg.mimeApps = {
    enable = true;
    # change default apps for a file or link type
    defaultApplications = {
      "text/html" = [
        "floorp.desktop"
      ];
      "x-scheme-handler/http" = [
        "floorp.desktop"
      ];
      "x-scheme-handler/https" = [
        "floorp.desktop"
      ];
      "x-scheme-handler/about" = [
        "floorp.desktop"
      ];
      "x-scheme-handler/unknown" = [
        "floorp.desktop"
      ];
      "application/pdf" = [
        "org.pwmt.zathura.desktop"
      ];
      "image/png" = [
        "floorp.desktop"
      ];
      "image/jpeg" = [
        "floorp.desktop"
      ];
      "video/mp4" = [ "umpv.desktop" ];
      "video/x-matroska" = [ "umpv.desktop" ]; # .mkv
      "video/webm" = [ "umpv.desktop" ];
      "video/x-msvideo" = [ "umpv.desktop" ]; # .avi
      "video/quicktime" = [ "umpv.desktop" ]; # .mov
      "video/x-flv" = [ "umpv.desktop" ];
      "video/mpeg" = [ "umpv.desktop" ];
      "video/ogg" = [ "umpv.desktop" ];
      "inode/directory" = [
        "org.gnome.Nautilus.desktop"
      ];
    };
  };
}
