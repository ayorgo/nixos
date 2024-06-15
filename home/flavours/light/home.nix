{ lib, pkgs, ... }:

{
  imports = [ ../../common.nix ];

  programs.kitty.theme = "Adwaita light";
  programs.neovim.extraLuaConfig = (builtins.readFile ../../programs/neovim/init.lua + "\n" + "vim.cmd([[set background=light | let g:airline_theme='sol']])");
  home.file."/home/ayorgo/.doom.d/config.el" = {
    text = (builtins.readFile ../../dotfiles/emacs/config.el) + "\n" + "(setq doom-theme 'doom-one-light)";
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
