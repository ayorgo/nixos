{ lib, pkgs, ... }:

{
  imports = [ ../common.nix ];

  programs.kitty.theme = "Adwaita light";
  programs.neovim.extraLuaConfig = (builtins.readFile ../dotfiles/vim/init.lua + "\n" + "vim.cmd([[set background=light | let g:airline_theme='sol']])");
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
