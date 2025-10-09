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
        #!/bin/sh

        # Read secrets from environment (set by systemd service, I can't forget this again, this was a nightmare to relearn. Also, obviously the following script isn't done by me)
        if [ -f /etc/environment.d/50-weather-secrets.conf ]; then
          . /etc/environment.d/50-weather-secrets.conf
        fi

        # Validate that we have the required secrets
        if [ -z "$WEATHER_API_KEY" ] || [ "$WEATHER_API_KEY" = "YOUR_API_KEY_HERE" ]; then
          echo "{\"text\": \"🔑 API Key Missing\", \"tooltip\": \"Weather API key not configured in sops\"}"
          exit 1
        fi

        if [ -z "$WEATHER_LOCATION" ]; then
          echo "{\"text\": \"📍 Location Missing\", \"tooltip\": \"Weather location not configured in sops\"}"
          exit 1
        fi

        # Debug output to a log file
        LOG_FILE="/tmp/waybar-weather.log"
        echo "$(date): Weather script started with location: $WEATHER_LOCATION" > "$LOG_FILE"

        # Check if jq is available
        if ! command -v jq >/dev/null 2>&1; then
          echo "{\"text\": \"🌡️ Error: jq not found\", \"tooltip\": \"Please install jq\"}"
          echo "$(date): jq not found" >> "$LOG_FILE"
          exit 1
        fi

        # Fetch weather data with verbose error logging
        get_weather_data() {
          echo "$(date): Attempting to fetch weather data..." >> "$LOG_FILE"

          # Parse location - use lat,lon format
          lat=$(echo "$WEATHER_LOCATION" | cut -d',' -f1)
          lon=$(echo "$WEATHER_LOCATION" | cut -d',' -f2)

          weather=$(curl -s --connect-timeout 15 \
            "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$WEATHER_API_KEY&units=imperial" \
            2>> "$LOG_FILE")
          curl_status=$?

          echo "$(date): curl exit status: $curl_status" >> "$LOG_FILE"
          if [ $curl_status -eq 0 ] && [ -n "$weather" ]; then
            # Check if the result is valid JSON
            if echo "$weather" | jq . >/dev/null 2>&1; then
              api_code=$(echo "$weather" | jq -r '.cod')
              echo "$(date): API response code: $api_code" >> "$LOG_FILE"

              if [ "$api_code" = "200" ]; then
                echo "$(date): Successfully fetched valid weather data" >> "$LOG_FILE"
                printf "%s\n" "$weather"
                return 0
              else
                # Handle specific API error codes
                error_msg=$(echo "$weather" | jq -r '.message // "Unknown error"' 2>/dev/null || echo "Unknown error")
                echo "$(date): API error (code $api_code): $error_msg" >> "$LOG_FILE"

                case "$api_code" in
                  "401")
                    echo "{\"text\": \"🔑 API Key Issue\", \"tooltip\": \"API key invalid or not activated yet. New keys take up to 2 hours to activate.\"}"
                    ;;
                  "404")
                    echo "{\"text\": \"📍 Location Not Found\", \"tooltip\": \"Coordinates not found. Check coordinates format.\"}"
                    ;;
                  "429")
                    echo "{\"text\": \"⏰ Rate Limited\", \"tooltip\": \"Too many API requests. Try again later.\"}"
                    ;;
                  *)
                    echo "{\"text\": \"❌ API Error\", \"tooltip\": \"$error_msg\"}"
                    ;;
                esac
                return 1
              fi
            else
              echo "$(date): Invalid JSON response" >> "$LOG_FILE"
              echo "$(date): Response was: ''${weather:0:200}..." >> "$LOG_FILE"
            fi
          else
            echo "$(date): Failed to fetch data (curl failed or empty response)" >> "$LOG_FILE"
          fi

          echo "{\"text\": \"🌐 Connection Error\", \"tooltip\": \"Unable to connect to weather service\"}"
          return 1
        }

        weather=$(get_weather_data)

        # If get_weather_data already returned a formatted error, just output it
        if echo "$weather" | jq -e '.text' >/dev/null 2>&1; then
          printf "%s\n" "$weather"
          exit 0
        fi

        echo "$(date): Processing weather data" >> "$LOG_FILE"

        # Check if we got valid weather data
        if [ "$(echo "$weather" | jq -r 'has("main") and has("weather")')" = "true" ]; then
          condition=$(echo "$weather" | jq -r '.weather[0].description')
          temp_f=$(echo "$weather" | jq -r '.main.temp | round')
          feels_like_f=$(echo "$weather" | jq -r '.main.feels_like | round')
          humidity=$(echo "$weather" | jq -r '.main.humidity')
          wind_speed=$(echo "$weather" | jq -r '.wind.speed | round')
          wind_deg=$(echo "$weather" | jq -r '.wind.deg // 0')
          weather_id=$(echo "$weather" | jq -r '.weather[0].id')
          city_name=$(echo "$weather" | jq -r '.name')

          echo "$(date): Weather data for $city_name: $condition, ''${temp_f}°F" >> "$LOG_FILE"

          # Convert wind direction from degrees to compass direction
          get_wind_direction() {
            deg=$1
            if [ "$deg" -ge 0 ] && [ "$deg" -lt 23 ]; then echo "N"
            elif [ "$deg" -ge 23 ] && [ "$deg" -lt 68 ]; then echo "NE"
            elif [ "$deg" -ge 68 ] && [ "$deg" -lt 113 ]; then echo "E"
            elif [ "$deg" -ge 113 ] && [ "$deg" -lt 158 ]; then echo "SE"
            elif [ "$deg" -ge 158 ] && [ "$deg" -lt 203 ]; then echo "S"
            elif [ "$deg" -ge 203 ] && [ "$deg" -lt 248 ]; then echo "SW"
            elif [ "$deg" -ge 248 ] && [ "$deg" -lt 293 ]; then echo "W"
            elif [ "$deg" -ge 293 ] && [ "$deg" -lt 338 ]; then echo "NW"
            else echo "N"
            fi
          }

          wind_dir=$(get_wind_direction "$wind_deg")

          # Determine appropriate icon based on OpenWeatherMap weather codes
          if [ "$weather_id" -ge 200 ] && [ "$weather_id" -lt 300 ]; then
            icon="⛈️"  # Thunderstorm
          elif [ "$weather_id" -ge 300 ] && [ "$weather_id" -lt 400 ]; then
            icon="🌦️"  # Drizzle
          elif [ "$weather_id" -ge 500 ] && [ "$weather_id" -lt 600 ]; then
            icon="🌧️"  # Rain
          elif [ "$weather_id" -ge 600 ] && [ "$weather_id" -lt 700 ]; then
            icon="❄️"  # Snow
          elif [ "$weather_id" -ge 700 ] && [ "$weather_id" -lt 800 ]; then
            icon="🌫️"  # Atmosphere (fog, haze, etc.)
          elif [ "$weather_id" -eq 800 ]; then
            # Check if it's day or night for clear sky
            current_time=$(date +%s)
            sunrise=$(echo "$weather" | jq -r '.sys.sunrise')
            sunset=$(echo "$weather" | jq -r '.sys.sunset')
            if [ "$current_time" -ge "$sunrise" ] && [ "$current_time" -lt "$sunset" ]; then
              icon="☀️"  # Clear day
            else
              icon="🌙"  # Clear night
            fi
          elif [ "$weather_id" -gt 800 ] && [ "$weather_id" -lt 900 ]; then
            icon="☁️"  # Clouds
          else
            icon="🌡️"  # Default
          fi

          # Capitalize first letter of condition
          condition=$(echo "$condition" | sed 's/\b\w/\U&/g')

          # Create tooltip with additional weather info including city name
          tooltip="$city_name: $condition - ''${temp_f}°F (feels like ''${feels_like_f}°F)\nHumidity: ''${humidity}%\nWind: ''${wind_speed} mph $wind_dir"

          # Output the weather information in JSON format
          result="{\"text\": \"$icon ''${temp_f}°F (''${feels_like_f}°F)\", \"tooltip\": \"$tooltip\"}"
          printf "%s\n" "$result"
          echo "$(date): Generated output: $result" >> "$LOG_FILE"
        else
          # Print the raw response for debugging
          echo "$(date): Invalid response structure. Raw data: ''${weather:0:200}..." >> "$LOG_FILE"
          printf "%s\n" "{\"text\": \"🌡️ Weather Unavailable\", \"tooltip\": \"Could not fetch weather data - check /tmp/waybar-weather.log\"}"
        fi
      '';
    };
    backup_content = {};
  };
}
