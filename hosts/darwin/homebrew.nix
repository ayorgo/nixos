{
  enable = true;
  onActivation.cleanup = "zap";
  onActivation.autoUpdate = true;
  onActivation.upgrade = true;
  casks = [
    "qobuz"
    "karabiner-elements"
    # Requires all the applications in /Applications/Wacom\ Tablet.localized/
    # to be manually dragged and dropped to "Accessibility Access" System list
    "wacom-tablet"
  ];
  brews = [
  ];
  taps = [
  ];
}
