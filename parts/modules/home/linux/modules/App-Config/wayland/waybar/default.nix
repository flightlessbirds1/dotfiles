{
  config,
  flake,
  username,
  hostname,
  ...
}: {
  programs.waybar = {
    enable = true;
    systemd.enable = false;
    # systemd.target = "graphical-session.target";
    settings = {
      mainBar = {
        position = "bottom";
        layer = "top";
        height = 32;
        margin-top = 0;
        margin-bottom = 5;
        margin-left = 5;
        margin-right = 5;
        modules-left = [
          "custom/launcher"
          "hyprland/workspaces"
          "wlr/workspaces"
        ];

        modules-center = [
          "custom/weather"
        ];

        modules-right = [
          "tray"
          "privacy"
          "cpu"
          "memory"
          "disk"
          "pulseaudio"
          "bluetooth"
          "battery"
          "clock"
        ];

        clock = {
          calendar = {
            format = {
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          format = " {:%I:%M %p}";
          tooltip = true;
          tooltip-format = ''
            <big>{:%B %Y}</big>
            <tt><small>{calendar}</small></tt>'';
          format-alt = " {:%m/%d/%Y}";
        };

        "custom/weather" = {
          return-type = "json";
          exec = "/home/${config.home.username}/.config/scripts/get_weather.sh";
          format = "{}";
          tooltip = true;
          interval = 120; # 2 minutes
        };

        "hyprland/workspaces" = {
          active-only = false;
          disable-scroll = true;
          format = "{icon}";
          on-click = "activate";
          format-icons = {
            "1" = "◉";
            "2" = "◉";
            "3" = "◉";
            "4" = "◉";
            "5" = "◉";
            urgent = "";
            default = "◉";
            sort-by-number = true;
          };
          persistent-workspaces = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            "5" = [];
          };
        };

        "wlr/workspaces" = {
          format = "{icon}";
          on-click = "activate";
          format-icons = {
            "03-music" = "◉";
            "04-web" = "◉";
            urgent = "";
            default = "◉";
          };
          sort-by-name = true;
          all-outputs = true;
        };

        memory = {
          format = "󰟜 {}%";
          format-alt = "󰟜 {used} GiB";
          interval = 2;
        };

        cpu = {
          format = "  {usage}%";
          format-alt = "  {avg_frequency} GHz";
          interval = 2;
        };

        disk = {
          format = "󰋊 {percentage_used}%";
          interval = 60;
        };

        tray = {
          icon-size = 12;
          spacing = 8;
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          tooltip = false;
          format-muted = " Muted";
          on-click = "easyeffects";
          on-scroll-up = "pactl set-sink-volume @DEFAULT_SINK@ +5%";
          on-scroll-down = "pactl set-sink-volume @DEFAULT_SINK@ -5%";
          scroll-step = 5;
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
              ""
            ];
          };
        };

        "custom/launcher" = {
          format = "";
          on-click = "~/.config/fuzzel/fuzzel-app-launcher.sh";
          tooltip = false;
        };

        privacy = {
          icon-spacing = 8;
          icon-size = 12;
          transition-duration = 250;
          modules = {
            screenshare = {
              type = "screenshare";
              tooltip = true;
              tooltip-icon-size = 12;
            };
            audio-out = {
              type = "audio-out";
              tooltip = true;
              tooltip-icon-size = 12;
            };
            audio-in = {
              type = "audio-in";
              tooltip = true;
              tooltip-icon-size = 12;
            };
          };
        };

        battery = {
          format = "{icon} {capacity}%";
          format-alt = "{icon} {time}";
          format-charging = " {capacity}%";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
          format-plugged = " {capacity}%";
          states = {
            critical = 15;
            warning = 30;
          };
        };

        bluetooth = {
          format = " {status}";
          format-connected = " {device_alias}";
          format-connected-battery = " {device_alias} {device_battery_percentage}%";
          tooltip-format = ''
            {controller_alias}	{controller_address}

            {num_connections} connected'';
          tooltip-format-connected = ''
            {controller_alias}	{controller_address}

            {num_connections} connected

            {device_enumerate}'';
          tooltip-format-enumerate-connected = "{device_alias}	{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}	{device_address}	{device_battery_percentage}%";
          on-click = "blueman-manager";
          format-disabled = " Disabled";
        };
      };
    };

    style = ''
      * {
          min-height: 0px;
          font-family: JetBrainsMono Nerd Font;
          font-weight: bold;
      }

      window#waybar {
          background: rgba(17, 17, 27, 0.9);
          color: #a6adc8;
          border: 2px solid;
          border-radius: 30px;
          border-color: #cba6f7;
          min-height: 30px;
          transition: background-color 0.3s ease, opacity 0.3s ease;
      }

      #workspaces {
          font-size: 18px;
          padding-left: 15px;
          margin-bottom: 2px;
      }
      #workspaces button {
          color: #a6adc8;
          padding: 5px;
          opacity: 1;
          transition: color 0.2s ease;
      }
      #workspaces button.empty {
          color: #a6adc8;
      }
      #workspaces button.active {
          color: #cba6f7;
      }
      #workspaces button:hover {
          background: rgba(203, 166, 247, 0.2);
          border-radius: 4px;
      }

      #tray, #pulseaudio, #bluetooth, #privacy, #cpu, #memory, #disk, #clock {
          font-size: 16px;
          color: #cba6f7;
          padding-right: 10px;
          transition: color 0.2s ease, background-color 0.2s ease;
      }

      #battery {
          font-size: 16px;
          color: #cba6f7;
          padding-right: 10px;
      }
      #battery.critical {
          color: #f38ba8;
          animation: blink 1s infinite;
      }
      @keyframes blink {
          to {
              color: #a6adc8;
          }
      }

      #custom-launcher {
          font-size: 20px;
          color: #cba6f7;
          font-weight: bold;
          padding-left: 10px;
          transition: color 0.2s ease;
      }
      #custom-launcher:hover {
          color: #f5c2e7;
      }

      #custom-weather {
          font-size: 14px;
          color: #cba6f7;
          font-weight: bold;
      }

      /* Smooth hover transitions for clickable elements */
      #tray, #pulseaudio, #bluetooth, #custom-launcher, #clock {
          padding: 0 8px;
          border-radius: 4px;
      }
      #tray:hover, #pulseaudio:hover, #bluetooth:hover, #custom-launcher:hover, #clock:hover {
          background-color: rgba(203, 166, 247, 0.2);
      }
    '';
  };
  home.file.".config/scripts/get_weather.sh" = flake.self.checker.function {
    inherit
      username
      hostname
      ;
    concatenation_type = "attribute";
    portable_content = {};
    unportable_content = {
      executable = true;
      text = ''
        #!/usr/bin/env nu

        let table = (cat /etc/environment.d/50-weather-secrets.conf
            | lines
            | each {split row "="}
            | flatten
            | chunks 2
            | each { {key: $in.0, value: $in.1} }
            | transpose -r -d)
        let lat = $table | (get WEATHER_LOCATION | split row "," | get 0)
        let lon = $table | (get WEATHER_LOCATION | split row "," | get 1)
        let API_KEY = $table | (get WEATHER_API_KEY)

        let values = (http get $"https://api.openweathermap.org/data/2.5/weather?lat=($lat)&lon=($lon)&appid=($API_KEY)&units=imperial")


        let temp = $values | get main | get temp | math round
        let name = $values | get name
        let real_feel = $values | get main | get feels_like | math round
        let weather = ($values | get weather)
        let id = ($weather | get id)
        let status = ($weather | get description | first)
        let humidity = ($values | get main | get humidity)
        def get_weather_icon [code: string] {
            match $code {
                "01d" => "☀️",
                "01n" => "🌙",
                "02d" => "🌤️",
                "02n" => "☁️",
                "03d" | "03n" => "☁️",
                "04d" | "04n" => "☁️",
                "09d" | "09n" => "🌧️",
                "10d" => "🌦️",
                "10n" => "🌧️",
                "11d" | "11n" => "⛈️",
                "13d" | "13n" => "❄️",
                "50d" | "50n" => "🌫️",
                _ => "🌡️"
            }
        }

        let icon = (get_weather_icon ($weather | get icon | first))
        let output = {
          text : $"($icon) ($temp)°F"
          tooltip : $"($name): ($status) - ($real_feel)"
        }

        print ($output | to json -r)
      '';
    };
    backup_content = {};
  };
}
