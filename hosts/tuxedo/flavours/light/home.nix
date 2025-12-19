{ lib, pkgs, ... }:

{
  imports = [ ../../common.nix ];

  programs.kitty.themeFile = "OneHalfLight";
  programs.kitty.settings.active_tab_foreground = "#383A42";  # `foreground` colour from OneHalfLight
  programs.kitty.settings.active_tab_background = "#FAFAFA";  # `background` colour from OneHalfLight
  programs.kitty.settings.inactive_tab_background = "#FAFAFA";  # `background` colour from OneHalfLight
  programs.neovim.extraLuaConfig = (builtins.readFile ../../../../programs/neovim/init.lua + "\n" + "vim.cmd([[set background=light]])");
  home.file."/home/ayorgo/.emacs.d/init.el" = {
    text = "(setq my-theme-flavour \"light\")" + "\n" + (builtins.readFile ../../../../programs/emacs/init.el);
  };
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "default";
    };
    "org/gnome/desktop/background" = {
      picture-uri = "file://" + ../../../wallpapers/nix-wallpaper-binary-white.png;
    };
  };
  home.file.".config/nvim/bg".text = "light";
}
