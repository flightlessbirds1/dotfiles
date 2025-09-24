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
        "evince.desktop"
      ];
      "image/png" = [
        "firefox.desktop"
      ];
      "image/jpeg" = [
        "firefox.desktop"
      ];
    };
  };
}
