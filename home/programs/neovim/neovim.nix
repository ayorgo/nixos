{ lib, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    plugins = [
      pkgs.vimPlugins.nerdtree
      pkgs.vimPlugins.indentLine
      pkgs.vimPlugins.vim-commentary
      pkgs.vimPlugins.fzf-vim
      pkgs.vimPlugins.colorizer
      pkgs.vimPlugins.vim-airline
      pkgs.vimPlugins.vim-airline-themes
      pkgs.vimPlugins.catppuccin-nvim
      pkgs.vimPlugins.vim-nix
      pkgs.vimPlugins.auto-save-nvim
    ];
    extraLuaConfig = lib.mkDefault (builtins.readFile ./init.lua + "\n" + "vim.cmd([[set background=dark | let g:airline_theme='dark']])");
  };
}
