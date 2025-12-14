{ lib, pkgs, config, ... }:

{
  programs.bash = {
    enable = true;
    bashrcExtra = builtins.readFile ./.bashrc + "\n" + builtins.readFile ./.bash_aliases;
  };
}
