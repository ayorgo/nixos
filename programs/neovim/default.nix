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
      auto-save-nvim
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
      image-nvim
    ];
    extraPackages = [
      pkgs.gcc  # required for treesitter to work properly
      pkgs.imagemagick  # required for image-nvim to work properly
    ];
    initLua = builtins.readFile ./init.lua;
  };
  home.file.".bigqueryrc".text = ''
--project_id=my-project
--format=csv

[query]
--use_legacy_sql=false
--max_rows=150
'';
}
