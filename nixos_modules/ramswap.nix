{...}: {
  zramSwap = {
    enable = true;
    memoryPercent = 200;
    algorithm = "zstd";
    memoryMax = 16 * 1024 * 1024 * 1024;
    priority = 100;
  };
}
