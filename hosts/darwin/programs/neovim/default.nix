{ lib, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      fzf-lua
      ccc-nvim
      auto-save-nvim
      nvim-treesitter.withAllGrammars
      vim-fugitive
      vim-rhubarb
      indent-blankline-nvim
      csvview-nvim
      mini-files
      mini-icons
      mini-sessions
      mini-statusline
      mini-tabline
      onedark-nvim
      smart-splits-nvim
    ];
    extraPackages = [
      pkgs.gcc  # required for treesitter to work properly
    ];
    extraLuaConfig = lib.mkDefault (builtins.readFile ./init.lua);
  };
}
