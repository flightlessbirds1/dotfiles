let
  mkIcon = icon: color: name: {
    inherit icon color name;
  };
in
{
  programs.nixvim.plugins.web-devicons = {
    autoLoad = true;
    enable = true;

    settings = {
      override_by_extension = {
        lean = mkIcon "∀" "#3b82f6" "Lean";
        hs = mkIcon "λ" "#eab308" "Haskell";
      };

      override_by_filename = {
        "lean-toolchain" = mkIcon "∃" "#eab308" "LeanToolchain";
        ".envrc" = mkIcon "$" "#f59e0b" "Envrc";
        ".bashrc" = mkIcon "$" "#f59e0b" "Bashrc";
        ".zshrc" = mkIcon "$" "#f59e0b" "Zshrc";
      };
    };
  };
}
