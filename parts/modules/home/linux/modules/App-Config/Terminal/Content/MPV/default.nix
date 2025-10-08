{pkgs, ...}: {
  programs.mpv = {
    enable = true;
    config = {
      profile = "gpu-hq";
      scale = "ewa_lanczossharp";
      cscale = "ewa_lanczossharp";
      dscale = "mitchell";
      video-sync = "display-resample";
      interpolation = true;
      tscale = "oversample";
      hwdec = "auto-safe";
      vo = "gpu-next";
      gpu-api = "auto";
      border = false;
      title = "\${filename}";
      keepaspect-window = false;
      snap-window = true;
      window-maximized = true;
      osc = false;
      osd-bar = false;
      osd-font = "SF Pro Display";
      osd-font-size = 28;
      osd-color = "#FFFFFF";
      osd-border-color = "#00000000";
      osd-shadow-offset = 2;
      osd-shadow-color = "#AA000000";
      osd-duration = 1500;
      osd-margin-x = 20;
      osd-margin-y = 20;
      sub-font = "SF Pro Display";
      sub-font-size = 44;
      sub-color = "#FFFFFF";
      sub-border-color = "#00000000";
      sub-shadow-offset = 2;
      sub-shadow-color = "#CC000000";
      sub-margin-y = 50;
      sub-blur = 0.2;
      sub-auto = "fuzzy";
      sub-file-paths = "sub:subtitles:subs";
      volume = 80;
      volume-max = 200;
      audio-pitch-correction = true;
      audio-channels = "auto-safe";
      hr-seek = "yes";
      save-position-on-quit = true;
      watch-later-directory = "~/.cache/mpv/watch_later";
      screenshot-format = "png";
      screenshot-high-bit-depth = true;
      screenshot-png-compression = 9;
      screenshot-directory = "~/Pictures/Screenshots";
      screenshot-template = "%F_%P";
      cache = true;
      cache-secs = 300;
      demuxer-max-bytes = "500MiB";
      demuxer-max-back-bytes = "200MiB";
      demuxer-readahead-secs = 30;
      stream-buffer-size = "10MiB";
      force-seekable = true;
      player-operation-mode = "pseudo-gui";
      keep-open = true;
      keep-open-pause = false;
      force-window = true;
      idle = true;
      x11-bypass-compositor = "yes";
      cursor-autohide = 800;
      deband = true;
      deband-iterations = 2;
      deband-threshold = 35;
      deband-range = 16;
      deband-grain = 48;
      hr-seek-framedrop = false;
      video-latency-hacks = true;
      target-colorspace-hint = true;
      dither-depth = "auto";
      temporal-dither = true;
      dither = "fruit";
      screenshot-sw = false;
      correct-downscaling = true;
      linear-downscaling = true;
      sigmoid-upscaling = true;
      blend-subtitles = "yes";
    };

    scripts = with pkgs.mpvScripts; [
      modernx-zydezu
      thumbfast
      mpris
      mpv-playlistmanager
      sponsorblock
      quality-menu
      manga-reader
      autosub
    ];

    bindings = {
      "MBTN_LEFT" = "ignore";
      "MBTN_LEFT_DBL" = "cycle fullscreen";
      "MBTN_RIGHT" = "cycle pause";
      "MBTN_MID" = "ignore";
      "WHEEL_UP" = "seek 5";
      "WHEEL_DOWN" = "seek -5";
      "WHEEL_LEFT" = "add volume -2";
      "WHEEL_RIGHT" = "add volume 2";
      "LEFT" = "seek -5";
      "RIGHT" = "seek 5";
      "UP" = "seek 60";
      "DOWN" = "seek -60";
      "Alt+1" = "set window-scale 0.5";
      "Alt+2" = "set window-scale 1.0";
      "Alt+3" = "set window-scale 1.5";
      "Alt+4" = "set window-scale 2.0";
      "9" = "add volume -2";
      "0" = "add volume 2";
      "f" = "cycle fullscreen";
      "SPACE" = "cycle pause";
      "m" = "cycle mute";
      "s" = "screenshot";
      "S" = "screenshot video";
      "q" = "script-binding quality_menu/video_formats_toggle";
      "ESC" = "set fullscreen no";
      "ENTER" = "cycle fullscreen";
      "v" = "cycle sub-visibility";
      "j" = "cycle sub";
      "J" = "cycle sub down";
      "a" = "cycle audio";
      "A" = "cycle audio down";
      "[" = "multiply speed 0.9";
      "]" = "multiply speed 1.1";
      "BS" = "set speed 1.0";
      "b" = "cycle deband";
      "i" = "cycle interpolation";
      "I" = "script-binding stats/display-stats-toggle";
      "P" = "script-binding mpv_playlistmanager/showplaylist";
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
}
