{ lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim-remote
  ];

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
      pkgs.vimPlugins.copilot-vim
      pkgs.vimPlugins.catppuccin-nvim
      pkgs.vimPlugins.vim-nix
      pkgs.vimPlugins.auto-save-nvim
    ];
    extraLuaConfig = lib.mkDefault (builtins.readFile ./dotfiles/vim/init.lua + "\n" + "vim.cmd([[set background=dark | let g:airline_theme='dark']])");
  };
}
