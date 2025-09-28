{
  pkgs,
  lib,
  config,
  ...
}: {
  home.file.".config/fcitx5/conf/quickphrase.conf" = {
    text = ''
      # Choose key modifier
      Choose Modifier=None
      # Enable Spell check
      Spell=True
      # Fallback Spell check language
      FallbackSpellLanguage=en

      [TriggerKey]
      0=Control+Shift+Multi_key
    '';
  };
}
