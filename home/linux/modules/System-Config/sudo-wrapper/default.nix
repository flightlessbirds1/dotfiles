{ config, pkgs, ... }:

{
  home.file."scripts/sudo" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      # Wrapper for doas-sudo-shim to filter unsupported flags from nh

      FILTERED_ARGS=()

      for arg in "$@"; do
          case "$arg" in
              --preserve-env|--preserve-env=*|-E)
                  # Skip these - doas preserves most env vars by default
                  ;;
              *)
                  FILTERED_ARGS+=("$arg")
                  ;;
          esac
      done

      exec /run/current-system/sw/bin/sudo "''${FILTERED_ARGS[@]}"
    '';
  };
}
