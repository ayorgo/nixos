{ lib, pkgs, ... }:

{
  imports = [ ../../common.nix ];

  programs.kitty.themeFile = "Doom_One_Light";
  programs.neovim.extraLuaConfig = (builtins.readFile ../../programs/neovim/init.lua + "\n" + "vim.cmd([[set background=light | let g:airline_theme='sol']])");
  home.file."/home/ayorgo/.emacs.d/init.el" = {
    text = "(setq my-theme-flavour \"light\")" + "\n" + (builtins.readFile ../../programs/emacs/init.el);
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
