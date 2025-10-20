{ lib, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    themeFile = lib.mkDefault "OneHalfDark";
    settings = {

      # Don't phone home
      update_check_interval = 0;

      # Tabs
      tab_bar_edge = "top";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      active_tab_font_style = "bold";
      inactive_tab_font_style = "normal";
      inactive_tab_foreground = "#999999";

      # Clicking on URLs
      mouse_map = "ctrl+left release grabbed,ungrabbed mouse_handle_click link";
      mouse_hide_wait = -1;

      # Background opacity
      # background_opacity = 1.0;

      # Sound bell
      enable_audio_bell = "no";

      # Font
      font_family = "SauceCodePro NF SemiBold";
      bold_font = "SauceCodePro NF Bold";
      font_size = 11;

      # Remote control
      allow_remote_control = "yes";

      # Don't ask to close window
      confirm_os_window_close = 0;

      # Hide the title bar and window borders
      hide_window_decorations = "yes";

      # Fade text in inactive windows
      inactive_text_alpha = 0.5;
      active_border_color = "none";

      # Stacked tab title decorations
      tab_title_template = "{bell_symbol}{activity_symbol}{' ' if layout_name == 'stack' and num_windows > 1 else ''}{tab.active_wd.rsplit('/', 1)[-1]}";

      kitty_mod = "alt";

      text_composition_strategy="legacy";

      cursor = "#999999";
    };
    keybindings = {
      # Clipboard
      "kitty_mod+c" = "copy_or_interrupt";
      "kitty_mod+v" = "paste_from_clipboard";

      # Window management
      "kitty_mod+enter" = "launch --cwd=current";
      "kitty_mod+s" = "toggle_layout stack";
      "kitty_mod+up" = "resize_window taller";
      "kitty_mod+down" = "resize_window shorter";
      "kitty_mod+left" = "resize_window narrower";
      "kitty_mod+right" = "resize_window wider";
      "shift+tab" = "next_window";

      # Tab management
      "ctrl+t" = "new_tab";
      "ctrl+shift+t" = "set_tab_title";

      # Scrollback buffer
      "ctrl+k" = "scroll_line_up";
      "ctrl+j" = "scroll_line_down";
      "kitty_mod+h" = "launch --type=overlay --stdin-source=@screen_scrollback --cwd=current nvim -u NONE -i NONE -c 'normal G' -c 'colorscheme vim' -c 'map q :q!<CR>' -c 'set clipboard=unnamedplus laststatus=0 nospell nomodifiable syntax=' -";
      "kitty_mod+g" = "launch --type=overlay --stdin-source=@last_cmd_output --cwd=current nvim -u NONE -i NONE -c 'normal G' -c 'colorscheme vim' -c 'map q :q!<CR>' -c 'set clipboard=unnamedplus laststatus=0 nospell nomodifiable syntax=' -";
    };
  };
}
