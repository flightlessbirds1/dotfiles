{
  inputs,
  pkgs,
  lib,
  config,
  username,
  ...
}: let
  ENABLE_TOP_SEARCHBAR_USERCHROME = true;

  newtabs = import ./newtabs.nix {};
  extensions = import ./extension_ids.nix {};
  redirect = pkgs.callPackage ./redirect {
    redirect_id = extensions.redirect;
  };
  default_newtab = builtins.toJSON newtabs.default_newtab;
  personal_newtab = builtins.toJSON newtabs.personal_newtab;
  school_newtab = builtins.toJSON newtabs.school_newtab;
  study_newtab = builtins.toJSON newtabs.study_newtab;
  bookmarks = import ./bookmarks;
  search = import ./search;
  containers = import ./containers.nix {};

  additional_preferences = import ./preferences.nix {
    inherit
      pkgs
      lib
      config
      inputs
      ;
  };
  hardening_preferences = import ./hardening_preferences.nix {};

  userChrome_preferences =
    if ENABLE_TOP_SEARCHBAR_USERCHROME
    then (import ./userChrome_preferences.nix {})
    else {};

  top_searchbar_userChrome = import ./top_searchbar_userChrome.nix;
  top_searchbar_userChrome_attrs = profile_name:
    if ENABLE_TOP_SEARCHBAR_USERCHROME
    then {
      userChrome = top_searchbar_userChrome profile_name;
    }
    else {};

  test_userChrome = import ./test_userChrome.nix {};

  mkProfile = name: id: use_containers: preferences: enable_top_searchbar_userChrome: extensions: additional_attrs: {
    "${name}" =
      {
        inherit
          name
          id
          ;

        extensions.packages = extensions;

        containers = use_containers;

        containersForce = true;

        settings =
          additional_preferences
          // preferences
          // (
            if enable_top_searchbar_userChrome
            then userChrome_preferences
            else {}
          );
      }
      // search
      // bookmarks
      // (
        if enable_top_searchbar_userChrome
        then top_searchbar_userChrome_attrs name
        else {}
      )
      // additional_attrs;
  };

  # Actual profile definitions
  # TODO: split this file up into multiple files, reorganize Firefox folder to be more hierarchical

  default_profile =
    mkProfile username 0 containers.default
    {
      "browser.newtabpage.pinned" = default_newtab;
      "media.eme.enabled" = false;
      "extensions.autoDisableScopes" = 0;
    }
    true
    (with inputs.firefox-addons.packages.${pkgs.system}; [
      darkreader
      bitwarden
      vimium
      translate-web-pages
      redirect
      mal-sync
      ff2mpv
    ])
    (bookmarks
      // search);

  personal_profile =
    mkProfile "personal" 1 containers.personal
    {
      "browser.newtabpage.pinned" = personal_newtab;
      "extensions.autoDisableScopes" = 0;
    }
    true
    (with inputs.firefox-addons.packages.${pkgs.system}; [
      darkreader
      bitwarden
      vimium
      translate-web-pages
      redirect
    ])
    {};

  hardened_profile = mkProfile "hardened" 2 containers.hardened hardening_preferences true [] {};

  test_profile =
    mkProfile "test" 3 containers.hardened (hardening_preferences // userChrome_preferences) false []
    {
      userChrome = test_userChrome;
    };

  school_profile =
    mkProfile "school" 4 containers.school
    {
      "browser.newtabpage.pinned" = school_newtab;
      "extensions.autoDisableScopes" = 0;
    }
    true
    (with inputs.firefox-addons.packages.${pkgs.system}; [
      darkreader
      bitwarden
      zotero-connector
      translate-web-pages
      chameleon-ext
    ])
    {};

  study_profile =
    mkProfile "study" 5 containers.study
    {
      "browser.newtabpage.pinned" = study_newtab;
      "extensions.autoDisableScopes" = 0;
    }
    true
    (with inputs.firefox-addons.packages.${pkgs.system}; [
      darkreader
      bitwarden
      vimium
      translate-web-pages
    ])
    {
      bookmarks = import ./bookmarks/bookmarks-study.nix {};
    };

  all_profiles = [
    default_profile
    personal_profile
    hardened_profile
    test_profile
    school_profile
    study_profile
  ];
in
  lib.attrsets.mergeAttrsList all_profiles
