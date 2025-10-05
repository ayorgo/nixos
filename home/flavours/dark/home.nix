{ lib, pkgs, ... }:

{
  imports = [ ../../common.nix ];

  programs.kitty.themeFile = "Doom_One";
  programs.neovim.extraLuaConfig = (builtins.readFile ../../programs/neovim/init.lua + "\n" + "vim.cmd([[set background=dark | let g:airline_theme='dark']])");
  home.file."/home/ayorgo/.emacs.d/init.el" = {
    text = "(setq my-theme-flavour \"dark\")" + "\n" + (builtins.readFile ../../programs/emacs/init.el);
  };
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
    "org/gnome/desktop/background" = {
      picture-uri = "file://" + ../../../wallpapers/nix-wallpaper-binary-black.png;
    };
  };
}

