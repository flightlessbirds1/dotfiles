{lib, ...}: let
  ThirdParty = "3rdparty";
  extensions = import ./extension_ids.nix {};
in {
  AppAutoUpdate = false;
  RequestedLocales = "es-ES,es,en-US,en";

  DisableTelemetry = true; # sets
  datareporting.healthreport.uploadEnabled = false;
  datareporting.policy.dataSubmissionEnabled = false;
  toolkit.telemetry.archive.enabled = false;

  DisableFirefoxStudies = true; # does not affect preferences

  EnableTrackingProtection = {
    Value = true;
    Locked = true;
    Cryptomining = true; # sets privacy.trackingprotection.crytomining.enabled = true
    Fingerprinting = true; # sets privacy.trackingprotection.fingerprinting.enabled = true
  };

  SanitizeOnShutdown = {
    Downloads = true; # sets privacy.clearOnShutdown.downloads
    History = true; # sets privacy.clearOnShutdown.history
    Locked = true;
  };

  DisablePocket = true; # sets extensions.pocket.enabled to false;
  DisableFirefoxAccounts = true; # sets identity.fxaccounts.enabled to false;
  DisableFirefoxScreenshots = false; # sets extensions.screenshots.disabled to false;
  DontCheckDefaultBrowser = true;
  DisplayBookmarksToolbar = "always"; # alternatives: "always" or "newtab"
  SearchBar = "unified"; # alternative: "separate"

  ExtensionSettings = with extensions; {
    # also blocks about:debugging
    "*".installation_mode = "blocked"; # blocks all addons except the ones specified below

    "${ublock_origin}" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
      installation_mode = "force_installed";
    };
    "${solid_black_theme}" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/solid-black-theme/latest.xpi";
      installation_mode = "force_installed";
    };
    "${dark_reader}" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
      installation_mode = "force_installed";
    };
    "${bitwarden}" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
      installation_mode = "allowed";
    };
    "${vimium}" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi";
      installation_mode = "allowed";
    };
    "${violentmonkey}" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/violentmonkey/latest.xpi";
      installation_mode = "allowed";
    };
    "${sponsorblock}" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
      installation_mode = "allowed";
    };
    "${mal-sync}" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/mal-sync/latest.xpi";
      installation_mode = "allowed";
    };
    "${omnivore}" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/omnivore/latest.xpi";
      installation_mode = "allowed";
    };
    "${translate-web-pages}" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/traduzir-paginas-web/latest.xpi";
      installation_mode = "force_installed";
    };
    "${redirect}" = {
      installation_mode = "allowed";
    };
    "${kagi-search}" = {
      installation_mode = "allowed";
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/kagi-search-for-firefox/latest.xpi";
    };
    "${movie-web}" = {
      installation_mode = "allowed";
      install_url = "https://addons.mozilla.org/firefox/downloads/file/4286163/cfu_flix_movie_web_extension-1.1.4.xpi";
    };
    "${chameleon-ext}" = {
      installation_mode = "allowed";
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/chameleon-ext/latest.xpi";
    };
  };

  ${ThirdParty}.Extensions = {
    "uBlock0@raymondhill.net" = import ../shared/ublock_origin {
      inherit
        lib
        ;
    };

    "${extensions.redirect}" = import ./redirect/settings.nix;
  };

  "${extensions.redirect}" = {
    "redirects" = {
      "www.reddit.com" = {
        changes = "every_time";
        source = {
          domain = "www.reddit.com";
        };
        targets = [
          {
            domain = "safereddit.com";
          }
          {
            domain = "redlib.ducks.party";
          }
          {
            domain = "redlib.tux.pizza";
          }
        ];
      };
    };
  };

  Preferences = {
    # Philosophy: Lock as much as possible so that we have to change stuff in Nix for reproducibility

    # A lot of the security and privacy stuff was taken from
    # https://brainfucksec.github.io/firefox-hardening-guide

    # UI configurations
    "browser.aboutConfig.showWarning" = false;
    "browser.aboutwelcome.enabled" = false;
    "browser.tabs.firefox-view" = false;
    "browser.tabs.tabmanager.enabled" = false;
    "browser.startup.page" = 3;
    "browser.search.openintab" = true;

    # Adblocking and Annoyances
    "browser.contentblocking.features.strict" = "tp,tpPrivate,cookieBehavior5,cookieBehaviorPBM5,cm,fp,stp,emailTP,emailTPPrivate,lvl2,rp,rpTop,ocsp,qps,qpsPBM,fpp,fppPrivate";
    "browser.contentblocking.category" = "strict";
    "browser.newtabpage.activity-stream.showSponsored" = false;
    "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
    "browser.newtabpage.activity-stream.topSitesRows" = 2;
    "browser.newtabpage.activity-stream.feeds.system.topstories" = false;
    "browser.newtabpage.activity-stream.feeds.topsites" = true;
    "browser.urlbar.suggest.quicksuggest.sponsored" = false;
    "signon.rememberSignons" = false;
    "signon.autofillForms" = false;
    "signon.formlessCapture.enabled" = false;

    # Form autofill
    "browser.formfill.enable" = false;
    "extensions.formautofill.available" = "off";
    "extensions.formautofill.addresses.enabled" = false;
    "extensions.formautofill.heuristics.enabled" = false;
    "extensions.formautofill.creditCards.enabled" = false;
    "extensions.formautofill.creditCards.available" = false;

    # Enable extensions on all pages
    "extensions.enabledScopes" = 5;
    "extensions.webextensions.restrictedDomains" = "";

    # Privacy
    "extensions.pocket.enabled" = false;
    "geo.provider.use_gpsd" = false;
    "geo.provider.use_geoclue" = false;

    # Telemetry
    "browser.newtabpage.activity-stream.feeds.telemetry" = false;
    "browser.newtabpage.activity-stream.telemetry" = false;
    "browser.newtabpage.activity-stream.feeds.snippets" = false;
    "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
    "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
    "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
    "extensions.getAddons.showPane" = false; # uses Google Analytics
    "extensions.htmlaboutaddons.recommendations.enabled" = false;
    "browser.discovery.enabled" = false;
    "browser.ping-centre.telemetry" = false;

    # No crash reports
    "browser.tabs.crashReporting.sendReport" = false;

    # HTTPS/SSL/TLS/OSCP/CERTS
    "dom.security.https_only_mode" = true;
    "dom.security.https_only_mode_send_http_background_request" = false;
    "browser.xul.error_pages.expert_bad_cert" = true;
    "security.tls.enable_0rtt_data" = false;
    "security.OCSP.require" = true;

    # Misc security
    "network.IDN_show_punycode" = true;

    # enable hardware acceleration
    "gfx.webrender.force-disabled" = false;
    "layers.acceleration.disabled" = false;
    "urlclassifier.trackingSkipURLs" = "claude.ai,statsig.anthropic.com,a-cdn.anthropic.com,r.stripe.com,js.stripe.com,m.stripe.network,intercom.io";
    "urlclassifier.trackingAnnotationWhitelistHosts" = "claude.ai,anthropic.com";
  };
}
