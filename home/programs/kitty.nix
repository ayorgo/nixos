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
      tab_powerline_style = "round";

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

      # Stacked tab title decorations
      tab_title_template = "{bell_symbol}{activity_symbol}{' ' if layout_name == 'stack' and num_windows > 1 else ''}{fmt.fg.tab}{tab.active_wd.rsplit('/', 1)[-1]}";

      kitty_mod = "ctrl";
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
      "shift+tab" = "next_window";

      # Tab management
      "kitty_mod+t" = "new_tab";
      "kitty_mod+shift+t" = "set_tab_title";

      # Scrollback buffer
      "kitty_mod+k" = "scroll_line_up";
      "kitty_mod+j" = "scroll_line_down";
      "alt+h" = "launch --type=overlay --stdin-source=@screen_scrollback --cwd=current nvim -u NONE -i NONE -c 'normal G' -c 'colorscheme vim' -c 'map q :q!<CR>' -c 'set clipboard=unnamedplus laststatus=0 nospell nomodifiable syntax=' -";
      "alt+g" = "launch --type=overlay --stdin-source=@last_cmd_output --cwd=current nvim -u NONE -i NONE -c 'normal G' -c 'colorscheme vim' -c 'map q :q!<CR>' -c 'set clipboard=unnamedplus laststatus=0 nospell nomodifiable syntax=' -";
    };

  # Unmap
  extraConfig = ''
    # Keep context search working in the terminal
    map ctrl+r
    # Don't close Kitty on kitty_mod+q
    map ctrl+q
    # Allow for navigation in Vim
    map ctrl+h
    map ctrl+l
  '';
  };
}
