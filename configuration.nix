# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, lib, ... }:

let
  dotfiles = builtins.fetchGit {
    url = "https://github.com/ayorgo/dotfiles";
    ref = "master";
  };
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      (import "${builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz}/nixos")
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-7c0e9142-00aa-4fb9-9d41-d73628940915".device = "/dev/disk/by-uuid/7c0e9142-00aa-4fb9-9d41-d73628940915";
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Ensure GNOME and GDM are enabled
  services.xserver = {
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
  };

  services.gnome.games.enable = true;

  environment.gnome.excludePackages = with pkgs.gnome; [
    baobab      # disk usage analyzer
    cheese      # photo booth
    eog         # image viewer
    epiphany    # web browser
    gedit       # text editor
    simple-scan # document scanner
    totem       # video player
    yelp        # help viewer
    evince      # document viewer
    file-roller # archive manager
    geary       # email client
    seahorse    # password manager

    # these should be self explanatory
    gnome-calculator gnome-calendar gnome-characters gnome-clocks gnome-contacts gnome-font-viewer gnome-logs
    gnome-maps gnome-music gnome-system-monitor gnome-weather gnome-disk-utility pkgs.gnome-connections
  ];

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ayorgo = {
    isNormalUser = true;
    description = "ayorgo";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable nix-command
  nix.settings.experimental-features = [ "nix-command" "flakes"];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    kitty
    gitFull
    btop
    killall
  #  wget
  ];

  environment.variables = {
    EDITOR = "vim";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  home-manager.users.ayorgo = { lib, ... }: {
    home.stateVersion = "23.11";

    home.packages = with pkgs; [
      spotify
      thunderbird
      freetube
      gnome.dconf-editor
    ];

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        enable-hot-corners = false;
        color-scheme = "prefer-dark";
        show-battery-percentage = true;
        scaling-factor = "1.75";
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
      "org/gnome/settings-daemon/plugins/media-keys" = {
        search = [ "<Alt>r" ];
      };
      "org/gnome/desktop/wm/keybindings" = {
        # switch-to-workspace-left = [ "<Super>a" ];
        # switch-to-workspace-right = [ "<Super>d" ];
        # move-to-workspace-left = [ "<Shift><Super>a" ];
        # move-to-workspace-right = [ "<Shift><Super>d" ];
        # switch-to-workspace-1 = [ "<Super>1" ];
        # switch-to-workspace-2 = [ "<Super>2" ];
        # switch-to-workspace-3 = [ "<Super>3" ];
        # switch-to-workspace-4 = [ "<Super>4" ];
        # switch-input-source = [ "<Shift><Alt>" ];
        # switch-input-source-backward = mkEmptyArray type.string;
        # activate-window-menu = [ "Menu" ];
        close = [ "<Alt>w" ];
        maximize = [ "<Alt>m" ];
        # toggle-fullscreen = [ "<Shift><Super>f" ];
      };
    };

    programs.git = {
      enable = true;
      userName = "Georgios Adzhygai";
      userEmail = "ayorgo@users.noreply.github.com";
      package = pkgs.gitFull;
    };

    programs.fzf.enable = true;

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
        source = "${dotfiles}/bash/.bashrc";
      };
      ".bash_aliases" = {
        source = "${dotfiles}/bash/.bash_aliases";
      };
      ".vimrc" = {
        source = "${dotfiles}/vim/.vimrc";
      };
      ".config/kitty/kitty.conf" = {
        source = "${dotfiles}/kitty/kitty.conf";
      };
      ".config/kitty/current-theme.conf" = {
        source = "${dotfiles}/kitty/current-theme.conf";
      };
    };
  };
}
