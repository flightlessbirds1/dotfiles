_: {
  services = {
    cliphist = {
      enable = true;
      allowImages = true;
      extraOptions = [
        "-max-items"
        "30"
        "-max-dedupe-search"
        "10"
      ];
    };
    wl-clip-persist = {
      enable = true;
    };
  };
}
