{
  menuExtraClock.Show24Hour = true; # Show the clock in 24 hours format
  dock = {
    autohide = true;
    orientation = "right";
    show-recents = false;
    autohide-delay = 0.0; # Remove the auto-hiding Dock delay
    autohide-time-modifier = 0.0; # Remove the animation when hiding/showing the Dock
    showhidden = true; # Make Dock icons of hidden applications translucent

    # Enable highlight hover effect for the grid view of a stack (Dock)
    mouse-over-hilite-stack = true;

    # Set the icon size of Dock items
    tilesize = 48;

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
    TrackpadThreeFingerDrag = true;
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

    # Metric everywhere
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
