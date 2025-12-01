_: {
  xdg.mimeApps = {
    enable = true;
    # change default apps for a file or link type
    defaultApplications = {
      "text/html" = [
        "firefox.desktop"
      ];
      "x-scheme-handler/http" = [
        "firefox.desktop"
      ];
      "x-scheme-handler/https" = [
        "firefox.desktop"
      ];
      "x-scheme-handler/about" = [
        "firefox.desktop"
      ];
      "x-scheme-handler/unknown" = [
        "firefox.desktop"
      ];
      "application/pdf" = [
        "org.pwmt.zathura.desktop"
      ];
      "image/png" = [
        "firefox.desktop"
      ];
      "image/jpeg" = [
        "firefox.desktop"
      ];
      "video/mp4" = ["umpv.desktop"];
      "video/x-matroska" = ["umpv.desktop"]; # .mkv
      "video/webm" = ["umpv.desktop"];
      "video/x-msvideo" = ["umpv.desktop"]; # .avi
      "video/quicktime" = ["umpv.desktop"]; # .mov
      "video/x-flv" = ["umpv.desktop"];
      "video/mpeg" = ["umpv.desktop"];
      "video/ogg" = ["umpv.desktop"];
      "inode/directory" = [
        "org.gnome.Nautilus.desktop"
      ];
    };
  };
}
