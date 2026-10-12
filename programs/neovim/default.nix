{ lib, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      fzf-lua
      ccc-nvim
      nvim-treesitter.withAllGrammars
      vim-fugitive
      fugitive-gitlab-vim
      vim-rhubarb
      gitsigns-nvim
      indent-blankline-nvim
      csvview-nvim
      mini-files
      mini-icons
      mini-statusline
      onedark-nvim
      smart-splits-nvim
      vim-dadbod
      barbar-nvim
      nvim-web-devicons
    ];
    extraPackages = [
      pkgs.gcc # required for treesitter to work properly
    ];
    initLua = builtins.readFile ./init.lua;
  };
  home.file.".bigqueryrc".text = ''
    --format=csv

    [query]
    --use_legacy_sql=false
    --max_rows=30000
  '';
}
