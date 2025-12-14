{ lib, pkgs, config, ... }:

{
  programs.zsh = {
    enable = true;
    initContent = builtins.readFile ./.zshrc;
  };
}
