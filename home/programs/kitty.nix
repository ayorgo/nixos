{ lib, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    themeFile = lib.mkDefault "adwaita_darker";
    settings = {

      # Don't phone home
      update_check_interval = 0;

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
    keybindings = {
      "ctrl+k" = "scroll_line_up";
      "ctrl+j" = "scroll_line_down";
      "ctrl+b" = "scroll_page_up";
      "ctrl+f" = "scroll_page_down";
      "shift+tab" = "next_window";
    };
  };
}

