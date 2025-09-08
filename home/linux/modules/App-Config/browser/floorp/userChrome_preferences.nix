{...}: {
  # Fixes issue where window border in GTK is curved but content pokes out
  "widget.gtk.rounded-bottom-corners.enabled" = true;

  # Does not stupidly hide everything in fullscreen
  "browser.fullscreen.autohide" = false;

  # Enables userChrome
  "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
}
