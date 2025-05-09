{ lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    dconf-editor
    gnomeExtensions.vitals
    gnomeExtensions.top-bar-organizer
    gnomeExtensions.launch-new-instance
    gnomeExtensions.hide-the-dock-in-overview
    gnomeExtensions.pip-on-top
    gnomeExtensions.appindicator
    gnomeExtensions.battery-health-charging
    polkit
    polkit_gnome
  ];

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      clock-format = "24h";
      clock-show-weekday = true;
    };
    "org/gnome/shell".enabled-extensions = with pkgs.gnomeExtensions; [
      vitals.extensionUuid
      top-bar-organizer.extensionUuid
      launch-new-instance.extensionUuid
      hide-the-dock-in-overview.extensionUuid
      pip-on-top.extensionUuid
      appindicator.extensionUuid
      battery-health-charging.extensionUuid
    ];
    "org/gnome/shell/extensions/Battery-Health-Charging" = {
      amend-power-indicator = true;
      charging-mode = "bal";
      ctl-path = "/usr/local/bin/batteryhealthchargingctl-ayorgo";
      default-threshold = true;
      device-type = 1;
      dummy-apply-threshold = true;
      dummy-default-threshold = true;
      icon-style-type = 1;
      indicator-position-max = 2;
      install-service = 0;
      polkit-installation-changed = true;
      polkit-status = "installed";
      root-mode = true;
      show-battery-panel2 = false;
      show-notifications = true;
      show-preferences = true;
      show-system-indicator = true;
    };
    "org/gnome/shell/extensions/appindicator" = {
      icon-size = 22;
    };
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
      show-battery = true;
      hot-sensors = [
        "_processor_usage_"
        "_memory_allocated_"
        "_storage_free_"
        "_battery_rate_"
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
      picture-uri = lib.mkDefault ("file://" + ../../../wallpapers/nix-wallpaper-binary-black.png);
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
}
