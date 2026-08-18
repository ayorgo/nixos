{
  lib,
  pkgs,
  config,
  ...
}:

{
  programs.zsh = {
    enable = true;
    initContent = builtins.readFile ./.zshrc;
    enableCompletion = false; # avoid loading completions twice
  };
}
