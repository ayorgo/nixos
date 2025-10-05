{ lib, pkgs, ... }:

{
  programs.librewolf = {
    enable = true;
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
      ExtensionSettings = {
        "*".installation_mode = "blocked"; # blocks all addons except the ones specified below
        # uBlock Origin:
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        # Multi-Account Containers:
        "@testpilot-containers" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/multi-account-containers/latest.xpi";
          installation_mode = "force_installed";
        };
        # Vimium
        "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi";
          installation_mode = "force_installed";
        };
        # Simple Translate
        "simple-translate@sienori" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/simple-translate/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
    profiles.default = {
      isDefault = true;
      search = {
        default = "ecosia";
        privateDefault = "ecosia";
        force = true; # allows this setting to work
        engines = {
          ecosia = {
            name = "Ecosia";
            urls = [{template = "https://www.ecosia.org/search?q={searchTerms}";}];
            icon = "https://www.ecosia.org/static/icons/favicon.ico";
            definedAliases = ["@eco"];
          };
          github = {
            name = "GitHub";
            urls = [ { template = "https://github.com/search?q={searchTerms}&type=code"; } ];
            iconMapObj."16" = "https://github.com/favicon.ico";
            definedAliases = [ "@gh" ];
          };
          nix-packages = {
            name = "Nix Packages";
            urls = [ { template = "https://search.nixos.org/packages?query={searchTerms}"; } ];
            icon = "''${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@nixp" ];
          };
          nixos-options = {
            name = "NixOS Options";
            urls = [ { template = "https://search.nixos.org/options?query={searchTerms}"; } ];
            icon = "''${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@nixo" ];
          };
          stack-overflow = {
            name = "Stack Overflow";
            urls = [ { template = "https://stackoverflow.com/search?q={searchTerms}"; } ];
            iconMapObj."16" = "https://cdn.sstatic.net/Sites/stackoverflow/Img/favicon.ico";
            definedAliases = [ "@so" ];
          };
          wikipedia = {
            name = "Wikipedia";
            urls = [ { template = "https://en.wikipedia.org/wiki/{searchTerms}"; } ];
            iconMapObj."16" = "https://en.wikipedia.org/favicon.ico";
            definedAliases = [ "@wiki" ];
          };
        };
      };
      settings = {
        "extensions.pocket.enabled" = false;
        "apz.kinetic_scroll.enabled" = false;
        "apz.gtk.kinetic_scroll.enabled" = false;
        "browser.ctrlTab.sortByRecentlyUsed" = true;
        "browser.search.region" = "GB";
        "browser.search.isUS" = false;
        "distribution.searchplugins.defaultLocale" = "en-GB";
        "general.useragent.locale" = "en-GB";
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
        "privacy.clearOnShutdown.cookies" = false;
        "privacy.clearOnShutdown.history" = false;
        "privacy.clearOnShutdown.downloads" = false;
        "privacy.clearOnShutdown.siteSettings" = false;
        "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
        "privacy.clearOnShutdown_v2.historyFormDataAndDownloads" = false;
        "privacy.clearOnShutdown_v2.siteSettings" = false;
        "privacy.resistFingerprinting" = false;
        "privacy.sanitize.sanitizeOnShutdown" = false;
        "browser.gesture.swipe.left" = "";
        "browser.gesture.swipe.right" = "";
      };
    };
  };
  imports = [
    ./vimium
  ];
}
