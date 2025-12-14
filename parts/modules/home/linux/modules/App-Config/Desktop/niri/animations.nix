_: {
  programs.niri.settings = {
    animations = {
      # Hyprland based animations
      window-open = {
        kind = {
          spring = {
            damping-ratio = 0.75;
            stiffness = 400;
            epsilon = 0.0001;
          };
        };
      };
      window-close = {
        kind = {
          easing = {
            duration-ms = 700;
            curve = "cubic-bezier";
            curve-args = [
              0.05
              0.9
              0.1
              1.05
            ];
          };
        };
        custom-shader = ''
          vec4 close_color(vec3 coords_geo, vec3 size_geo) {
            vec4 color = vec4(0.0);
            if (0.0 <= coords_geo.x && coords_geo.x <= 1.0 && 0.0 <= coords_geo.y && coords_geo.y <= 1.0) {
              float scale = 1.0 - 0.2 * niri_clamped_progress;
              vec2 centered = coords_geo.xy - vec2(0.5);
              vec2 scaled_coords = centered / scale + vec2(0.5);

              if (0.0 <= scaled_coords.x && scaled_coords.x <= 1.0 &&
                  0.0 <= scaled_coords.y && scaled_coords.y <= 1.0) {
                color = texture2D(niri_tex, scaled_coords) * (1.0 - niri_clamped_progress);
              }
            }
            return color;
          }
        '';
      };

      workspace-switch = {
        kind = {
          easing = {
            duration-ms = 300;
            curve = "cubic-bezier";
            curve-args = [
              0.05
              0.9
              0.1
              1.02
            ];
          };
        };
      };

      window-movement = {
        kind = {
          easing = {
            duration-ms = 350;
            curve = "cubic-bezier";
            curve-args = [
              0.13
              0.75
              0.29
              1.1
            ];
          };
        };
      };

      window-resize = {
        kind = {
          easing = {
            duration-ms = 500;
            curve = "cubic-bezier";
            curve-args = [
              0.05
              0.7
              0.1
              1.05
            ];
          };
        };
      };

      horizontal-view-movement = {
        kind = {
          easing = {
            duration-ms = 600;
            curve = "cubic-bezier";
            curve-args = [
              0.05
              0.9
              0.1
              1.05
            ];
          };
        };
      };

      config-notification-open-close = {
        kind = {
          easing = {
            duration-ms = 700;
            curve = "ease-out-cubic";
          };
        };
      };
    };
  };
}
