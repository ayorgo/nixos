{ lib, pkgs, ... }:

let
  OAuth2Settings = id: {
    "mail.smtpserver.smtp_${id}.authMethod" = 10;
    "mail.server.server_${id}.authMethod" = 10;
  };
in
{
  home.stateVersion = "23.11";

  systemd.user.services.watch-gnome-theme = {
    Unit = {
      Description = "Watch GNOME Theme Changes";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      Restart = "always";
      ExecStart = "${pkgs.writeShellScript "watch-gnome-theme" ''
        #!/run/current-system/sw/bin/bash
        dconf watch "/org/gnome/desktop/interface/color-scheme" | while read value; do
          if [[ "$value" == "'prefer-dark'" ]]; then
            sudo /etc/switch-specialisation dark && nvr -c 'AirlineTheme dark' --nostart -s && nvr -c 'set background=dark' --nostart -s
          fi
          if [[ "$value" == "'default'" ]]; then
            sudo /etc/switch-specialisation light && nvr -c 'AirlineTheme sol' --nostart -s && nvr -c 'set background=light' --nostart -s
          fi
        done
      ''}";
    };
  };

  home.packages = with pkgs; [
    spotify
    freetube
    gnome.dconf-editor
    gnomeExtensions.vitals
    gnomeExtensions.top-bar-organizer
    gnomeExtensions.launch-new-instance
    gnomeExtensions.hide-the-dock-in-overview
    gnomeExtensions.pip-on-top
    fastfetch
    neovim-remote
  ];

  dconf.settings = {
    "org/gnome/shell".enabled-extensions = [
      "Vitals@CoreCoding.com"
      "hide-dock-in-overview@roslax"
      "pip-on-top@rafostar.github.com"
      "top-bar-organizer@julian.gse.jsts.xyz"
      "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
    ];
    "org/gnome/desktop/peripherals/keyboard" = {
      delay = lib.hm.gvariant.mkUint32 175;
      repeat-interval = lib.hm.gvariant.mkUint32 20;
      repeat = true;
    };
    "org/gnome/settings-daemon/plugins/power" = {
      idle-dim = false;
      sleep-inactive-ac-type = "nothing";
      sleep-inactive-battery-type = "nothing";
      sleep-inactive-ac-timeout = 0;
      sleep-inactive-battery-timeout = 0;
    };
    "org/gnome/desktop/screensaver" = {
      lock-enabled = false;
    };
    "org/gnome/shell/extensions/top-bar-organizer" = {
      left-box-order = [
        "activities"
      ];
      center-box-order = [
        "dateMenu"
      ];
      right-box-order = [
        "vitalsMenu"
        "quickSettings"
        "keyboard"
      ];
    };
    "org/gnome/shell/extensions/vitals" = {
      fixed-widths = false;
      hot-sensors = [
        "_processor_usage_"
        "_memory_allocated_"
        "_storage_free_"
      ];
      menu-centered = false;
      position-in-panel = 2;  # 0: left box, 1: center box, 2: right box
    };
    "org/gnome/desktop/interface" = {
      enable-hot-corners = false;
      color-scheme = lib.mkDefault "prefer-dark";
      show-battery-percentage = true;
    };
    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = lib.mkDefault ("file://" + ../../wallpapers/nix-wallpaper-binary-black.png);
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      natural-scroll = false;
    };
    "org/gnome/mutter" = {
      edge-tiling = true;
      attach-modal-dialogs = true;
      experimental-features = [ "scale-monitor-framebuffer" ];
    };
    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-schedule-automatic = false;
      night-light-schedule-from = 0.0;
      night-light-schedule-to = 0.0;
      night-light-temperature = lib.hm.gvariant.mkUint32 4200;
    };
    "org/gnome/mutter" = {
      dynamic-workspaces = true;
    };
    "org/gnome/shell/app-switcher" = {
      current-workspace-only = true;
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      search = [ "<Alt>r" ];
      screensaver = [ "<Super>z" ];
    };
    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Alt>w" ];
      maximize = [ "<Alt>m" ];
      switch-windows = [ "<Alt>Tab" ];
      switch-applications = [];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Alt>Return";
      command = "kitty";
      name = "Terminal";
    };
    "org/gnome/settings-daemon/plugins/media-keys".custom-keybindings = [
      "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
    ];
  };

  programs.git = {
    enable = true;
    userName = "Georgios Adzhygai";
    userEmail = "ayorgo@users.noreply.github.com";
    package = pkgs.gitFull;
  };

  programs.kitty = {
    enable = true;
    theme = lib.mkDefault "Adwaita darker";
    settings = {
      # Tabs
      tab_bar_edge = "top";
      tab_bar_style = "powerline";
      tab_powerline_style = "round";

      # Clicking on URLs
      mouse_map = "ctrl+left release grabbed,ungrabbed mouse_handle_click link";

      # Background opacity
      # background_opacity = 1.0;

      # Sound bell
      enable_audio_bell = "no";

      # Font
      font_family = "Source Code Pro Medium";
      bold_font = "Source Code Pro Bold";
      font_size = 12;

      # Remote control
      allow_remote_control = "yes";

      # Don't ask to close window
      confirm_os_window_close = 0;

      # Hide the title bar and window borders
      hide_window_decorations = "yes";
    };
  };

  programs.neovim = {
    enable = true;
    plugins = [
      pkgs.vimPlugins.nerdtree
      pkgs.vimPlugins.indentLine
      pkgs.vimPlugins.vim-commentary
      pkgs.vimPlugins.fzf-vim
      pkgs.vimPlugins.colorizer
      pkgs.vimPlugins.vim-airline
      pkgs.vimPlugins.vim-airline-themes
      pkgs.vimPlugins.copilot-vim
      pkgs.vimPlugins.catppuccin-nvim
      pkgs.vimPlugins.vim-nix
      pkgs.vimPlugins.auto-save-nvim
    ];
    extraLuaConfig = lib.mkDefault (builtins.readFile ./dotfiles/vim/init.lua + "\n" + "vim.cmd([[set background=dark | let g:airline_theme='dark']])");
  };

  programs.thunderbird = {
    enable = true;
    profiles.default = {
      isDefault = true;
      settings = { };
    };
  };

  accounts.email.accounts = {
    gmail = {
      primary = true;
      flavor = "gmail.com";
      address = "george.adzhygai@gmail.com";
      realName = "Georgios Adzhygai";
      smtp.tls.useStartTls = true;
      thunderbird = {
        enable = true;
        settings = OAuth2Settings;
      };
    };
  };

  programs.fzf.enable = true;

  programs.ripgrep.enable = true;

  programs.firefox = {
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
      };
    };
    profiles.default = {
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
      };
    };
  };

  home.file = {
    ".bashrc" = {
      source = ./dotfiles/bash/.bashrc;
    };
    ".bash_aliases" = {
      source = ./dotfiles/bash/.bash_aliases;
    };
  };
}
