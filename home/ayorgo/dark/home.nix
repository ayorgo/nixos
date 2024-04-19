{ lib, pkgs, ... }:

{
  imports = [ ../common.nix ];

  programs.kitty.theme = "Adwaita darker";
  programs.neovim.extraLuaConfig = (builtins.readFile ../dotfiles/vim/init.lua + "\n" + "vim.cmd([[set background=dark | let g:airline_theme='dark']])");
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
    "org/gnome/desktop/background" = {
      picture-uri = "file://" + ../../../wallpapers/nix-wallpaper-binary-black.png;
    };
  };
}
