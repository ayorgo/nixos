{ lib, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      nerdtree
      indentLine
      vim-commentary
      fzf-vim
      colorizer
      vim-airline
      vim-airline-themes
      catppuccin-nvim
      vim-nix
      auto-save-nvim
    ];
    extraLuaConfig = lib.mkDefault (builtins.readFile ./init.lua + "\n" + "vim.cmd([[set background=dark | let g:airline_theme='dark']])");
  };
}
