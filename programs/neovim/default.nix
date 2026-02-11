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
      indent-blankline-nvim
      csvview-nvim
      mini-files
      mini-icons
      mini-sessions
      mini-statusline
      mini-tabline
      onedark-nvim
      smart-splits-nvim
      vim-dadbod
    ];
    extraPackages = [
      pkgs.gcc  # required for treesitter to work properly
    ];
    initLua = lib.mkDefault (builtins.readFile ./init.lua);
  };
  home.file.".bigqueryrc".text = ''
--project_id=my-project
--format=csv

[query]
--use_legacy_sql=false
--max_rows=150
'';
}
