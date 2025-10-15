{lib, ...}: let
  additional_filters_url = "https://gitlab.com/-/snippets/4789825/raw/main/snippetfile1.txt";
  unbreak_rules = import ./unbreak_rules.nix {};

  ENABLE_ADDITIONAL_FILTERS = true;
  ENABLE_UNBREAK_RULES = true;
in {
  userSettings = let
    importedLists = [
      additional_filters_url
    ];
  in
    [
      [
        "uiTheme"
        "dark"
      ]
      [
        "advancedUserEnabled"
        "true"
      ]
      [
        "uiAccentCustom"
        "true"
      ]
      [
        "uiAccentCustom0"
        "#8300ff"
      ]
      [
        "cloudStorageEnabled"
        "false"
      ]
      [
        "firewallPaneMinimized"
        "false"
      ]
    ]
    ++ (
      if ENABLE_ADDITIONAL_FILTERS
      then [
        [
          "importedLists"
          (builtins.toJSON additional_filters_url)
        ]
        [
          "externalLists"
          (lib.concatStringsSep "\n" importedLists)
        ]
      ]
      else []
    );
  adminSettings = builtins.toJSON {
    selectedFilterLists = [
      "user-filters"
      additional_filters_url
      "ublock-badlists"
      "ublock-filters"
      "ublock-badware"
      "ublock-privacy"
      "ublock-unbreak"
      "ublock-quick-fixes"
      "adguard-generic"
      "adguard-mobile"
      "easylist"
      "adguard-spyware-url"
      "adguard-spyware"
      "block-lan"
      "easyprivacy"
      "urlhaus-1"
      "curben-phishing"
      "adguard-cookies"
      "ublock-cookies-adguard"
      "fanboy-cookiemonster"
      "ublock-cookies-easylist"
      "adguard-social"
      "fanboy-social"
      "fanboy-thirdparty_social"
      "adguard-popup-overlays"
      "adguard-mobile-app-banners"
      "adguard-other-annoyances"
      "adguard-widgets"
      "easylist-annoyances"
      "easylist-chat"
      "easylist-newsletters"
      "easylist-notifications"
      "ublock-annoyances"
      "dpollock-0"
      "plowe-0"
      "spa-0"
      "spa-1"
    ];
    dynamicFilteringString = ''
      no-csp-reports: * true
      no-large-media: behind-the-scene false
      behind-the-scene * * noop
      behind-the-scene * 1p-script noop
      behind-the-scene * 3p noop
      behind-the-scene * 3p-frame noop
      behind-the-scene * 3p-script noop
      behind-the-scene * image noop
      behind-the-scene * inline-script noop
      ${
        if ENABLE_UNBREAK_RULES
        then unbreak_rules
        else ""
      }
    '';
  };
}
