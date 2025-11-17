{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    nixpkgs-firefox-darwin.url = "github:bandithedoge/nixpkgs-firefox-darwin";
    nur.url = "github:nix-community/NUR";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin-emacs = {
      url = "github:nix-giant/nix-darwin-emacs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin-emacs-packages = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self
    , nix-darwin
    , nixpkgs
    , home-manager
    , nixpkgs-firefox-darwin
    , nur
    , nix-homebrew
    , darwin-emacs
    , darwin-emacs-packages
  }:
  let
    configuration = { pkgs, ... }: {
      # Determinate uses its own daemon to manage the Nix installation that
      # conflicts with nix-darwin’s native Nix management.
      # Turn off nix-darwin’s management of the Nix installation:
      nix.enable = false;

      # Necessary for using flakes
      nix.settings.experimental-features = "nix-command flakes";

      users.users."ayorgo".home = "/Users/ayorgo";

      system = {
        primaryUser = "ayorgo";
        keyboard = {
          enableKeyMapping = true;
        };
        defaults = import ./macos.nix;

        # Set Git commit hash for darwin-version.
        configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        stateVersion = 5;
      };

      # The platform the configuration will be used on.
      nixpkgs = {
        hostPlatform = "aarch64-darwin";
        config.allowUnfree = true;
      };

      # `sudo` through fingerprint
      security.pam.services.sudo_local.touchIdAuth = true;

      # An alternative to `security.sudo.extraConfig`
      environment.etc = {
        "sudoers.d/10-nix-darwin-extra-config".text = let
          commands = [
            "/run/current-system/sw/bin/darwin-rebuild"
            "/nix/var/nix/profiles/default/bin/nix*"
            "/nix/store/*/activate"
          ];
          commandsString = builtins.concatStringsSep ", " commands;
        in ''
          # Set `sudo` timeout in minutes
          Defaults timestamp_timeout = 5

          # Share `sudo` timeout across terminals
          Defaults !tty_tickets

          # No `sudo` password for these commands
          %admin ALL=(ALL:ALL) NOPASSWD: ${commandsString}
        '';
      };

      homebrew = import ./homebrew.nix;
    };
  in
  {
    darwinConfigurations."simple-darwin" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        configuration
        home-manager.darwinModules.home-manager
        {
          nixpkgs.overlays = [
            nixpkgs-firefox-darwin.overlay
            nur.overlays.default
            darwin-emacs.overlays.emacs
            darwin-emacs-packages.overlays.package
          ];
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users."ayorgo" = import ./home.nix;
          };
        }
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            user = "ayorgo";
          };
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."simple-darwin".pkgs;
  };
}
