# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
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

  # Ensure GNOME and GDM are enabled
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
    xkb.layout = "us,us,ru";
    xkb.variant = ",dvorak,";
    wacom.enable = true;
  };

  services.gnome.games.enable = true;

  environment.gnome.excludePackages = (with pkgs.gnome; [
    baobab      # disk usage analyzer
    cheese      # photo booth
    eog         # image viewer
    epiphany    # web browser
    simple-scan # document scanner
    totem       # video player
    yelp        # help viewer
    evince      # document viewer
    file-roller # archive manager
    geary       # email client
    seahorse    # password manager

    # these should be self explanatory
    gnome-calculator gnome-characters gnome-clocks gnome-contacts gnome-font-viewer gnome-logs
    gnome-maps gnome-music gnome-system-monitor gnome-weather gnome-disk-utility pkgs.gnome-connections
  ]) ++ (with pkgs; [
    gedit       # text editor
    gnome-tour
  ]);

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [ hplip ];
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    # https://wiki.archlinux.org/title/PipeWire#Noticeable_audio_delay_or_audible_pop/crack_when_starting_playback
    wireplumber.configPackages = [
      (pkgs.writeTextDir
        "share/wireplumber/wireplumber.conf.d/51-disable-suspension.conf" ''
          monitor.alsa.rules = [
            {
              matches = [
                {
                  # Matches all sources
                  node.name = "~alsa_input.*"
                },
                {
                  # Matches all sinks
                  node.name = "~alsa_output.*"
                }
              ]
              actions = {
                update-props = {
                  session.suspend-timeout-seconds = 0
                }
              }
            }
          ]
          # bluetooth devices
          monitor.bluez.rules = [
            {
              matches = [
                {
                  # Matches all sources
                  node.name = "~bluez_input.*"
                },
                {
                  # Matches all sinks
                  node.name = "~bluez_output.*"
                }
              ]
              actions = {
                update-props = {
                  session.suspend-timeout-seconds = 0
                  dither.method = "wannamaker3",
                  dither.noise = 2,
                }
              }
            }
          ]
        '')
    ];
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
    wl-clipboard
    gitFull
    btop
    killall
    home-manager
    gnumake
  ];

  environment.variables = {
    EDITOR = "nvim";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs.steam.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # Docker
  virtualisation.docker = {
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
    daemon.settings.data-root = "/home/ayorgo/docker-cache";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than +5";
  };
}
