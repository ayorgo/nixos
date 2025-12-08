{ pkgs, user, ... }:

{
  # Night Shift settings
  # Courtesy of https://github.com/nix-darwin/nix-darwin/issues/1046
  # and https://raw.githubusercontent.com/philiprein/macos-settings/main/system_settings/displays.sh
  # To check the values in runtime:
  # sudo defaults read /var/root/Library/Preferences/com.apple.CoreBrightness.plist
  CustomSystemPreferences = {
    "/var/root/Library/Preferences/com.apple.CoreBrightness.plist" = let
      userId = builtins.readFile (pkgs.runCommand "user-id" {} "/usr/bin/dscl . -read user.home GeneratedUID | /usr/bin/sed 's/GeneratedUID: //' | /usr/bin/tr -d \\\\n > $out");
    in {
      "CBUser-${userId}" = {
        # Setting CBBlueLightReductionCCTTargetRaw doesn't really work for some reason.
        # The slider remains in the middle after reboot.
        CBBlueLightReductionCCTTargetRaw = "4800.064"; # The default is 4128.328
        CBBlueReductionStatus = {
          AutoBlueReductionEnabled = 1;
          BlueLightReductionAlgoOverride = 4;
          BlueLightReductionAlgoOverrideTimestamp = "3035-11-20 08:48:37 +0000";
          BlueLightReductionDisableScheduleAlertCounter = 3;
          BlueLightReductionSchedule = {
            DayStartHour = 1;
            DayStartMinute = 59;
            NightStartHour = 2;
            NightStartMinute = 0;
          };
          BlueReductionAvailable = 1;
          BlueReductionEnabled = 1;
          BlueReductionMode = 2;
          BlueReductionSunScheduleAllowed = 1;
          Version = 1;
        };
        CBColorAdaptationEnabled = 1;
      };
    };
  };
  menuExtraClock.Show24Hour = true; # Show the clock in 24 hours format
  controlcenter.BatteryShowPercentage = true;
  dock = {
    autohide = true;
    static-only = true;
    orientation = "left";
    show-recents = false;
    autohide-delay = 0.0; # Remove the auto-hiding Dock delay
    autohide-time-modifier = 0.0; # Remove the animation when hiding/showing the Dock
    showhidden = true; # Make Dock icons of hidden applications translucent

    # Enable highlight hover effect for the grid view of a stack (Dock)
    mouse-over-hilite-stack = true;

    # Set the icon size of Dock items
    tilesize = 32;

    # Change minimize/maximize window effect
    mineffect = "scale";

    # Minimize windows into their application’s icon
    minimize-to-application = false;

    # Enable spring loading for all Dock items
    enable-spring-load-actions-on-all-items = true;

    # Show indicator lights for open applications in the Dock
    show-process-indicators = true;

    # Don’t animate opening applications from the Dock
    launchanim = false;

    # Speed up Mission Control animations
    expose-animation-duration = 0.1;

    # Don’t group windows by application in Mission Control
    # (i.e. use the old Exposé behavior instead)
    expose-group-apps = false;

    # Don’t show Dashboard as a Space
    dashboard-in-overlay = true;

    # Don’t automatically rearrange Spaces based on most recent use
    mru-spaces = false;

    # disable all hot corners
    wvous-bl-corner = 1;
    wvous-br-corner = 1;
    wvous-tl-corner = 1;
    wvous-tr-corner = 1;
  };
  finder = {
    AppleShowAllExtensions = true;
    AppleShowAllFiles = true;  # show hidden files
    FXPreferredViewStyle = "clmv";

    # Allow quitting via ⌘ + Q; doing so will also hide desktop icons
    QuitMenuItem = true;

    # Display full POSIX path as window title
    _FXShowPosixPathInTitle = true;

    # Show path breadcrumbs on path bar
    ShowPathbar = true;

    # Show status bar at the bottom of windows
    ShowStatusBar = true;

    # Default the current search scope to current folder not this Mac
    FXDefaultSearchScope = "SCcf";
  };
  trackpad = {
    Clicking = true;
    ActuationStrength = 0;  # 0 to enable Silent Clicking, 1 to disable. The default is null.
    FirstClickThreshold = 0;  # For normal click: 0 for light clicking, 1 for medium, 2 for firm. The default is null.
    ForceSuppressed = true;  # Whether to disable force click. The default is null.
    Dragging = true;
    DragLock = false;
    TrackpadThreeFingerDrag = true;
    TrackpadMomentumScroll = false;
  };
  CustomUserPreferences = {

    # Unmap certain key combinations
    "com.apple.symbolichotkeys" = {
      AppleSymbolicHotKeys = {
        # Show Launchpad on Opt-R (same as Alt-R)
        "160" = {
          enabled = true;
          value = {
            type = "standard";
            # To get these numbers:
            # 1. Run `defaults read com.apple.symbolichotkeys AppleSymbolicHotKeys`
            # 2. Set the shortcut via UI
            # 3. Run the command from 2. again
            # 4. Get the diff between 1. and 2. and see what's changed.
            # 5. The added entry will be the shortcut of interest.
            parameters = [
              114
              15
              524288
            ];
          };
        };
        # Mission Control / Spaces
        # So scrollback buffer navigation in kitty works
        "32" = { enabled = 0; }; # Mission Control (Ctrl-up_arrow)
        "33" = { enabled = 0; }; # Application windows (Ctrl-down_arrow)

        # Input source switching (Ctrl-Space)
        # So FZF fuzzy search works in Vim
        "60" = { enabled = 0; }; # Select previous input source
        "61" = { enabled = 0; }; # Select next input source
      };
    };

    # Keyboard layouts
    "com.apple.HIToolbox" = {
      AppleEnabledInputSources = [
        {
          InputSourceKind = "Keyboard Layout";
          "KeyboardLayout Name" = "U.S.";
          "KeyboardLayout ID" = 0;
        }
        {
          InputSourceKind = "Keyboard Layout";
          "KeyboardLayout Name" = "Dvorak";
          "KeyboardLayout ID" = 16300;
        }
      ];

      AppleCurrentKeyboardLayoutInputSourceID = "com.apple.keylayout.US";

      # Order in the menu bar / quick switcher (first is primary)
      AppleSelectedInputSources = [
        {
          "InputSourceKind" = "Keyboard Layout";
          "KeyboardLayout ID" = 0;
          "KeyboardLayout Name" = "U.S.";
          "InputSourceID" = "com.apple.keylayout.US";
        }
        {
          "InputSourceKind" = "Keyboard Layout";
          "KeyboardLayout ID" = 16300;
          "KeyboardLayout Name" = "Dvorak";
          "InputSourceID" = "com.apple.keylayout.Dvorak";
        }
      ];
    };
  };
  NSGlobalDomain = {
    AppleInterfaceStyle = null; # Light theme; also "Dark"
    AppleInterfaceStyleSwitchesAutomatically = false;
    AppleKeyboardUIMode = 3; # full control
    ApplePressAndHoldEnabled = false; # Accents
    AppleShowAllExtensions = true; # Finder: show all filename extensions
    NSAutomaticCapitalizationEnabled = false;
    NSAutomaticDashSubstitutionEnabled = false; # No em dash
    NSAutomaticQuoteSubstitutionEnabled = false; # No smart quotes
    NSAutomaticPeriodSubstitutionEnabled = false; # No smart period
    NSAutomaticSpellingCorrectionEnabled = false; # No autocorrect

    # Disable "Natural" scrolling
    "com.apple.swipescrolldirection" = false;

    # Tap to click. Unclear how this overlaps with trackpad.Clicking.
    # This actually enables the tap+drag to select behaviour like in Linux.
    "com.apple.mouse.tapBehavior" = 1;

    # Locale
    AppleMetricUnits = 1;
    AppleMeasurementUnits = "Centimeters";
    AppleTemperatureUnit = "Celsius";
    AppleICUForce24HourTime = true;

    # Expand save panel by default
    NSNavPanelExpandedStateForSaveMode = true;
    NSNavPanelExpandedStateForSaveMode2 = true;

    # Expand print panel by default
    PMPrintingExpandedStateForPrint = true;
    PMPrintingExpandedStateForPrint2 = true;

    # Save to disk (not to iCloud) by default
    NSDocumentSaveNewDocumentsToCloud = false;

    # Disable automatic termination of inactive apps
    NSDisableAutomaticTermination = true;

    # Override the keyboard repeat rate
    InitialKeyRepeat = 10;
    KeyRepeat = 1;

    # Enable subpixel font rendering on non-Apple LCDs
    # Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
    AppleFontSmoothing = 1;
  };
}
