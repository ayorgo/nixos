{ lib, pkgs, ... }:

{
  imports = [ ../../common.nix ];

  programs.kitty.themeFile = "OneHalfDark";
  programs.kitty.settings.active_tab_foreground = "#dcdfe4";  # `foreground` colour from OneHalfDark
  programs.kitty.settings.active_tab_background = "#282c34";  # `background` colour from OneHalfDark
  programs.kitty.settings.inactive_tab_background = "#282c34";  # `background` colour from OneHalfDark
  programs.neovim.extraLuaConfig = (builtins.readFile ../../../../programs/neovim/init.lua + "\n" + "vim.cmd([[set background=dark]])");
  home.file."/home/ayorgo/.emacs.d/init.el" = {
    text = "(setq my-theme-flavour \"dark\")" + "\n" + (builtins.readFile ../../../../programs/emacs/init.el);
  };
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
    "org/gnome/desktop/background" = {
      picture-uri = "file://" + ../../wallpapers/nix-wallpaper-binary-black.png;
    };
  };
  home.file.".config/nvim/bg".text = "dark";
}

