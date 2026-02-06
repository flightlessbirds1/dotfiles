{
  services.pulseaudio = {
    enable = false;
  };
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    extraConfig.pipewire.noresample = {
      "context.properties" = {
        "default.clock.allowed-rates" = [
          44100
          48000
          192000
        ];
      };
    };
  };
}
