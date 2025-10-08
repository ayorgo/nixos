{ lib, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-commentary
      fzf-vim
      ccc-nvim
      vim-airline
      vim-airline-themes
      vim-nix
      auto-save-nvim
      nvim-treesitter
      nvim-treesitter.withAllGrammars
      gitsigns-nvim
      indent-blankline-nvim
      csvview-nvim
      mini-files
      mini-icons
      hop-nvim
      onedark-nvim
    ];
    extraLuaConfig = lib.mkDefault (builtins.readFile ./init.lua + "\n" + "vim.cmd([[set background=dark | let g:airline_theme='base16_twilight']])");
  };
}
