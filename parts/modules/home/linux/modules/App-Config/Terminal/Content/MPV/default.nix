{pkgs, ...}: {
  programs.mpv = {
    enable = true;
    config = {
      # High-quality video rendering
      profile = "gpu-hq";
      scale = "ewa_lanczossharp";
      cscale = "ewa_lanczossharp";
      dscale = "mitchell";
      video-sync = "display-resample";
      interpolation = true;
      tscale = "oversample";
      hwdec = "auto-safe";
      vo = "gpu-next";

      # Modern window styling
      border = false;
      title = "\${filename}";
      geometry = "50%:50%";
      autofit-larger = "85%x85%";
      keepaspect-window = false;
      snap-window = true;

      # Disable default OSC (we'll use modern alternative)
      osc = false;
      osd-bar = false;

      # Clean OSD styling
      osd-font = "SF Pro Display";
      osd-font-size = 28;
      osd-color = "#FFFFFF";
      osd-border-color = "#00000000";
      osd-shadow-offset = 2;
      osd-shadow-color = "#AA000000";
      osd-duration = 1500;
      osd-margin-x = 20;
      osd-margin-y = 20;

      # Beautiful subtitles
      sub-font = "SF Pro Display";
      sub-font-size = 44;
      sub-color = "#FFFFFF";
      sub-border-color = "#00000000";
      sub-shadow-offset = 2;
      sub-shadow-color = "#CC000000";
      sub-margin-y = 50;
      sub-blur = 0.2;

      # Audio improvements
      volume = 80;
      volume-max = 200;
      audio-pitch-correction = true;
      audio-channels = "auto-safe";

      # Smooth seeking and playback
      hr-seek = "yes";
      save-position-on-quit = true;
      watch-later-directory = "~/.cache/mpv/watch_later";

      # Screenshot settings
      screenshot-format = "png";
      screenshot-high-bit-depth = true;
      screenshot-png-compression = 9;
      screenshot-directory = "~/Pictures/Screenshots";
      screenshot-template = "%F_%P";

      # Performance
      cache = true;
      demuxer-max-bytes = "150MiB";
      demuxer-readahead-secs = 20;

      # Disable window decorations completely
      x11-bypass-compositor = "yes";
      cursor-autohide = 800;
    };

    scripts = with pkgs.mpvScripts; [
      uosc # Modern, beautiful UI
      thumbfast # Fast thumbnails
      mpris # Media keys support
    ];

    bindings = {
      # Mouse gestures
      "MBTN_LEFT" = "ignore";
      "MBTN_LEFT_DBL" = "cycle fullscreen";
      "MBTN_RIGHT" = "cycle pause";
      "MBTN_MID" = "ignore";

      # Modern controls
      "WHEEL_UP" = "seek 5";
      "WHEEL_DOWN" = "seek -5";
      "WHEEL_LEFT" = "add volume -2";
      "WHEEL_RIGHT" = "add volume 2";

      # Seek with precision
      "LEFT" = "seek -5";
      "RIGHT" = "seek 5";
      "UP" = "seek 60";
      "DOWN" = "seek -60";

      # Window scaling
      "Alt+1" = "set window-scale 0.5";
      "Alt+2" = "set window-scale 1.0";
      "Alt+3" = "set window-scale 1.5";
      "Alt+4" = "set window-scale 2.0";

      # Volume with visual feedback
      "9" = "add volume -2";
      "0" = "add volume 2";

      # Quick access
      "f" = "cycle fullscreen";
      "SPACE" = "cycle pause";
      "m" = "cycle mute";
      "s" = "screenshot";
      "S" = "screenshot video";

      # Quality of life
      "q" = "quit-watch-later";
      "ESC" = "set fullscreen no";
      "ENTER" = "cycle fullscreen";

      # Subtitle controls
      "v" = "cycle sub-visibility";
      "j" = "cycle sub";
      "J" = "cycle sub down";

      # Audio controls
      "a" = "cycle audio";
      "A" = "cycle audio down";

      # Playback speed
      "[" = "multiply speed 0.9091";
      "]" = "multiply speed 1.1";
      "BS" = "set speed 1.0";
    };
  };

  # uosc configuration for ultra-modern UI
  home.file.".config/mpv/script-opts/uosc.conf".text = ''
    # Interface
    ui=yes
    timeline_style=line
    timeline_line_width=2
    timeline_size=40
    controls=menu,gap,subtitles,<has_many_audio>audio,<has_many_video>video,<has_many_edition>editions,<stream>stream-quality,gap,space,speed,space,shuffle,loop-playlist,loop-file,gap,prev,items,next,gap,fullscreen
    controls_size=32
    controls_margin=8
    controls_spacing=2

    # Colors (dark theme with accent)
    color=foreground=ffffff
    color=foreground_text=000000
    color=background=000000
    color=background_text=ffffff
    color=curtain=111111
    color=success=00ff00
    color=error=ff0000

    # Behavior
    autohide=yes
    curtain_opacity=0.8
    refr rate=60
    animation=60
    proximity_in=40
    proximity_out=120

    # Volume
    volume=right
    volume_size=40
    volume_border=1
    volume_step=1
    volume_opacity=0.9

    # Top bar
    top_bar=no-border
    top_bar_size=40
    top_bar_controls=no
    top_bar_title=yes

    # Menu styling
    menu_item_height=36
    menu_min_width=260
    menu_opacity=0.95
    menu_radius=8
    menu_parent_opacity=0.4
  '';
}
