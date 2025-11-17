{ lib, pkgs, config, ... }:

{
  programs.librewolf = {
    enable = true;

    package = pkgs.librewolf.overrideAttrs (_: rec {
      override = _: pkgs.librewolf;
    });
    policies = {
      OfferToSaveLogins = false;
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value= true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      DisablePocket = true;
      DisableFirefoxAccounts = true;
      DisableAccounts = true;
      DisplayBookmarksToolbar = "never"; # alternatives: "always" or "newtab"
      DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
      SearchBar = "unified"; # alternative: "separate"
    };
    profiles.ayorgo = {
      isDefault = true;
      search = {
        default = "google";
        privateDefault = "google";
        force = true; # allows this setting to work
        engines = {
          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@nixp" ];
          };
          "Home Manager Options" = {
            urls = [{
              template = "https://home-manager-options.extranix.com/";
              params = [
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@nixhm" ];
          };
        };
      };
      settings = {
        # "security.cert_pinning.enforcement_level" = 1;
        "extensions.pocket.enabled" = false;
        "apz.kinetic_scroll.enabled" = false;
        "apz.gtk.kinetic_scroll.enabled" = false;
        "browser.ctrlTab.sortByRecentlyUsed" = true;
        "browser.search.region" = "GB";
        "browser.search.isUS" = false;
        "distribution.searchplugins.defaultLocale" = "en-GB";
        "general.useragent.locale" = "en-GB";
        "accessibility.typeaheadfind.prefillwithselection" = true; # prefill find with selected text

        "browser.topsites.contile.enabled" = false;
        "browser.formfill.enable" = false;
        "browser.search.suggest.enabled" = false;
        "browser.search.suggest.enabled.private" = false;
        "browser.urlbar.suggest.searches" = false;
        "browser.urlbar.showSearchSuggestionsFirst" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.snippets" = false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeVisited" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.system.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.startup.page" = "3";
        "signon.rememberSignons" = true; # remember passwords
        "signon.autofillForms" = true; # autofill passwords

        # Tab groups
        "browser.tabs.groups.enabled" = true;
        "browser.tabs.groups.smart.enabled" = true;
        "browser.tabs.groups.smart.optin" = true;
        "browser.tabs.groups.smart.userEnabled" = true;
        "browser.tabs.insertAfterCurrent" = true ;

        # Preserve sessions and history
        "privacy.resistFingerprinting" = false;
        "privacy.sanitize.sanitizeOnShutdown" = false;
        # "browser.sessionstore.resume_from_crash" = true;
        # "browser.sessionstore.restore_on_demand" = false;

        "privacy.clearOnShutdown.cache" = false;
        "privacy.clearOnShutdown.cookies" = false;
        "privacy.clearOnShutdown.downloads" = false;
        "privacy.clearOnShutdown.formdata" = false;
        "privacy.clearOnShutdown.history" = false;
        "privacy.clearOnShutdown.openWindows" = false;
        "privacy.clearOnShutdown.sessions" = false;
        "privacy.clearOnShutdown.siteSettings" = false;

        # "privacy.clearOnShutdown_v2.browsingHistoryAndDownloads" = false;
        # "privacy.clearOnShutdown_v2.cache" = false;
        # "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
        # "privacy.clearOnShutdown_v2.formdata" = false;
        # "privacy.clearOnShutdown_v2.history" = false;
        # "privacy.clearOnShutdown_v2.historyFormDataAndDownloads" = false;
        # "privacy.clearOnShutdown_v2.sessions" = false;
        # "privacy.clearOnShutdown_v2.siteSettings" = false;
      };
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        multi-account-containers
        ublock-origin
        surfingkeys
      ];
    };
  };
  home.file.".config/surfingkeys/surfingkeys.js" = {
    source = ./surfingkeys.js;
  };

  home.packages = [ pkgs.dufs ];

  # Serve surfingkeys.js to LibreWolf since FireFox
  # does not support loading configuration from files.
  # Don't forget to configure surfingkeys manually
  # in the browser by pointing it to http://localhost:5000/surfingkeys.js
  launchd.agents.dufs-surfingkeys = {
    enable = true;
    config = {
      ProgramArguments = [
        "${pkgs.dufs}/bin/dufs"
        "--allow-symlink"
        "${config.home.homeDirectory}/.config/surfingkeys"
      ];
      RunAtLoad = true;
      KeepAlive = true;
    };
  };
}
