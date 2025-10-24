{pkgs, ...}: {
  programs.mpv = {
    enable = true;
    config = {
      vo = "gpu-next";
      gpu-api = "vulkan";
      hwdec = "no";
      scale = "ewa_lanczossharp";
      cscale = "ewa_lanczossharp";
      dscale = "hermite";
      scale-antiring = 0.8;
      dscale-antiring = 0.8;
      cscale-antiring = 0.8;
      video-sync = "display-resample";
      interpolation = true;
      tscale = "oversample";
      interpolation-preserve = "no";
      deband = false;
      deband-iterations = 4;
      deband-threshold = 48;
      deband-range = 24;
      deband-grain = 16;
      dither = "fruit";
      video-crop = "0x0+0+0";
      fullscreen = true;
      border = false;
      title = "\${filename}";
      keepaspect-window = false;
      cursor-autohide = 100;
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
      sub-font = "Carlito";
      sub-font-size = 52;
      sub-blur = 0.1;
      sub-color = "#FFFFFF";
      sub-border-size = 3.2;
      sub-border-color = "#FF000000";
      sub-shadow-color = "#A0000000";
      sub-shadow-offset = 0.5;
      sub-bold = "yes";
      sub-margin-x = 100;
      sub-margin-y = 50;
      sub-auto = "fuzzy";
      sub-file-paths = "sub:subtitles:subs";
      demuxer-mkv-subtitle-preroll = "yes";
      sub-ass-use-video-data = "aspect-ratio";
      subs-with-matching-audio = "no";
      blend-subtitles = "yes";
      sub-fix-timing = "yes";
      sub-ass-override = "scale";
      sub-scale = 1.1;
      sub-gauss = 1.0;
      sub-gray = "yes";
      volume = 100;
      volume-max = 100;
      audio-file-auto = "fuzzy";
      audio-channels = "stereo,5.1,7.1";
      hr-seek = "yes";
      keep-open = "yes";
      save-position-on-quit = "no";
      force-seekable = "yes";
      autocreate-playlist = "same";
      screenshot-format = "png";
      screenshot-high-bit-depth = "yes";
      screenshot-png-compression = 1;
      screenshot-directory = "~/Pictures/Screenshots";
      screenshot-template = "%f-%wH.%wM.%wS.%wT-#%#00n";
      cache = true;
      demuxer-max-bytes = "500MiB";
      demuxer-max-back-bytes = "200MiB";
      demuxer-readahead-secs = 30;
      stream-buffer-size = "10MiB";
      alang = "ja,jp,jpn,en,eng,de,deu,ger";
      slang = "en,eng,de,deu,ger";
    };

    profiles = {
      youtube = {
        profile-cond = "path:find('youtu') ~= nil";
        save-position-on-quit = false;
        force-seekable = "yes";
        demuxer-max-back-bytes = "500MiB";
      };
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
      "h" = "cycle deband";
      "i" = "cycle interpolation";
      "I" = "script-binding stats/display-stats-toggle";
      "P" = "script-binding mpv_playlistmanager/showplaylist";
      "D" = "cycle deinterlace";
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

  home.file.".config/mpv/scripts/.keep".text = "";
}
