{ lib, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-commentary
      fzf-vim
      ccc-nvim
      vim-nix
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
    ];
    extraLuaPackages = ps: [ ps.magick ];
    extraPackages = [ pkgs.imagemagick pkgs.gcc ];
    extraLuaConfig = lib.mkDefault (builtins.readFile ./init.lua + "\n" + "vim.cmd([[set background=dark']])");
  };
}
