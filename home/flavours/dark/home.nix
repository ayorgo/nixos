{ lib, pkgs, ... }:

{
  imports = [ ../../common.nix ];

  programs.kitty.theme = "Adwaita darker";
  programs.neovim.extraLuaConfig = (builtins.readFile ../../programs/neovim/init.lua + "\n" + "vim.cmd([[set background=dark | let g:airline_theme='dark']])");
  home.file."/home/ayorgo/.doom.d/config.el" = {
    text = (builtins.readFile ../../dotfiles/emacs/config.el) + "\n" + "(setq doom-theme 'doom-one)";
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
