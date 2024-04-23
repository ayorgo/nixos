{ lib, pkgs, config, ... }:

{
  programs.bash = {
    enable = true;
    bashrcExtra = builtins.readFile ../dotfiles/bash/.bashrc + "\n" + builtins.readFile ../dotfiles/bash/.bash_aliases;
  };
}
