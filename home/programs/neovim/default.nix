{ lib, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      fzf-vim
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
    extraLuaPackages = ps: [ ps.magick ];
    extraPackages = [ pkgs.imagemagick pkgs.gcc ];
    extraPackages = [
      pkgs.gcc  # required for treesitter to work properly
    ];
    extraLuaConfig = lib.mkDefault (builtins.readFile ./init.lua + "\n" + "vim.cmd([[set background=dark']])");
  };
}
