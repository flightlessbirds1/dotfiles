{ pkgs, ... }:
{
  programs.mpv = {
    enable = true;
    config = {
      # General / Video Config

      profile = "high-quality";
      # Start in Fullscreen
      fullscreen = true;
      save-position-on-quit = true;
      # Make playlist of same files in same folder
      autocreate-playlist = "same";
      # Disable Default Display
      osc = false;
      #Don't show a huge volume box on screen when turning the volume up/down
      osd-bar = false;
      # Audio Priority
      alang = "en,eng,ja,jp,jpn";
      # Subtitle Priority
      slang = "en,eng,ja,jp,jpn";
      # Video Output Driver
      # See https://github.com/mpv-player/mpv/wiki/GPU-Next-vs-GPU
      vo = "gpu-next";
      gpu-api = "vulkan";
      # Resample audio to fix audio video sync errors
      video-sync = "display-resample";
      # Dither
      dither = "ordered";
      # HDR
      target-colorspace-hint = true;
      target-contrast = "auto";

      # Audio Config

      audio-spdif = "ac3,dts,eac3,dts-hd,truehd";

      # Subtitle Config

      blend-subtitles = true;
      sub-fix-timing = true;
    };

    scripts = with pkgs.mpvScripts; [
      # Theme
      modernx-zydezu
      # Keyboard Playback Controls
      mpris
      # Interactive Playlist Menu
      mpv-playlistmanager
      # Skip Sponsors for YouTube
      sponsorblock
      # Interactive Menu for Streaming Qualities
      quality-menu
      # Automatically Download Correct Subs
      autosub
      # Thumbnails for Seeking
      thumbfast
    ];

    bindings = {
      "MBTN_LEFT" = "ignore";
      "MBTN_LEFT_DBL" = "cycle fullscreen";
      "MBTN_RIGHT" = "cycle pause";
      "WHEEL_UP" = "add volume -2";
      "WHEEL_DOWN" = "add volume 2";
      "v" = "cycle sub-visibility";
      "a" = "cycle audio";
      "A" = "cycle audio down";
      "B" = "script-binding autosub/download_subs";
      "i" = "cycle interpolation";
      "I" = "script-binding stats/display-stats-toggle";
      "P" = "script-binding mpv_playlistmanager/showplaylist";
      "Ctrl+o" = "script-binding open-browser";
      "Tab" = "script-binding browse-files";
    };
  };

  home.file.".config/mpv/scripts/file-browser" = {
    source = pkgs.fetchFromGitHub {
      owner = "CogentRedTester";
      repo = "mpv-file-browser";
      rev = "master";
      sha256 = "sha256-zCDBxsGC7THQ2k0qDkjOq4TZm4thI2yk57a3i9PRCAs=";
    };
  };

  home.file.".config/mpv/script-opts/modernx.conf".text = ''
    idlescreen=yes
    windowcontrols=yes
    showwindowed=yes
    showfullscreen=yes
    greenandgrumpy=no
    scale=1.0
    hidetimeout=2000
    fadeduration=250
    font=SF Pro Display
    titlefontsize=30
    seekbarfg_color=FF5722
    seekbarbg_color=FFFFFF
    seekbar_cache_color=9E9E9E
    volumebar_color=FF5722
    timetotal=yes
    compactmode=no
  '';

  home.file.".config/mpv/script-opts/autosub.conf".text = ''
    languages=eng,en
  '';
}
