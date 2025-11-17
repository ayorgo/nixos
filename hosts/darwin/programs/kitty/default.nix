{ lib, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    themeFile = lib.mkDefault "OneHalfDark";
    shellIntegration.enableBashIntegration = true;
    settings = {
      shell = "bash";

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

      # Sound bell
      enable_audio_bell = "no";

      # Font
      font_family = "SauceCodePro NF SemiBold";
      bold_font = "SauceCodePro NF Bold";
      font_size = 11;

      # Remote control
      # Needed for smart-splits.nvim to work
      allow_remote_control = "yes";
      listen_on = "unix:@pussycat";

      # Always ask to close window
      confirm_os_window_close = 1;

      # Hide the title bar and window borders
      hide_window_decorations = "yes";

      # Fade text in inactive windows
      inactive_text_alpha = 0.4;
      active_border_color = "none";

      # Stacked tab title decorations
      tab_title_template = "{bell_symbol}{activity_symbol}{' ' if layout_name == 'stack' and num_windows > 1 else ''}{tab.active_wd.rsplit('/', 1)[-1]}";

      cursor = "#999999";
    };
    keybindings = {
      # Clipboard
      "ctrl+c" = "copy_or_interrupt";
      "ctrl+v" = "paste_from_clipboard";

      # Window management
      "alt+enter" = "launch --cwd=current";
      "alt+s" = "toggle_layout stack";
      "ctrl+j" = "neighboring_window down";
      "ctrl+k" = "neighboring_window up";
      "ctrl+h" = "neighboring_window left";
      "ctrl+l" = "neighboring_window right";
      "shift+tab" = "next_window";

      "alt+j" = "kitten relative_resize.py down  1";
      "alt+k" = "kitten relative_resize.py up    1";
      "alt+h" = "kitten relative_resize.py left  1";
      "alt+l" = "kitten relative_resize.py right 1";

      # Tab management
      "ctrl+t" = "new_tab";

      # Scrollback buffer
      "ctrl+up" = "scroll_line_up";
      "ctrl+down" = "scroll_line_down";
      "alt+b" = "launch --type=overlay --stdin-source=@screen_scrollback --cwd=current nvim -u NONE -i NONE -c 'normal G' -c 'colorscheme vim' -c 'map q :q!<CR>' -c 'set clipboard=unnamedplus laststatus=0 nospell nomodifiable syntax=' -";
      "alt+shift+b" = "launch --type=overlay --stdin-source=@last_cmd_output --cwd=current nvim -u NONE -i NONE -c 'normal G' -c 'colorscheme vim' -c 'map q :q!<CR>' -c 'set clipboard=unnamedplus laststatus=0 nospell nomodifiable syntax=' -";
    };

    # Unmap some bindings inside Vim
    extraConfig = ''
      map --when-focus-on var:IS_NVIM ctrl+j
      map --when-focus-on var:IS_NVIM ctrl+k
      map --when-focus-on var:IS_NVIM ctrl+h
      map --when-focus-on var:IS_NVIM ctrl+l

      map --when-focus-on var:IS_NVIM alt+j
      map --when-focus-on var:IS_NVIM alt+k
      map --when-focus-on var:IS_NVIM alt+h
      map --when-focus-on var:IS_NVIM alt+l

      map --when-focus-on var:IS_NVIM ctrl+v
    '';
  };
  home.file.".config/kitty/neighboring_window.py" = {
    source = "${pkgs.vimPlugins.smart-splits-nvim}/kitty/neighboring_window.py";
    executable = true;
  };
  home.file.".config/kitty/relative_resize.py" = {
    source = "${pkgs.vimPlugins.smart-splits-nvim}/kitty/relative_resize.py";
    executable = true;
  };
  home.file.".config/kitty/split_window.py" = {
    source = "${pkgs.vimPlugins.smart-splits-nvim}/kitty/split_window.py";
    executable = true;
  };
}
