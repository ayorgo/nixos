{ lib, pkgs, config, ... }:

{
  programs.starship = {
    enableBashIntegration = true;
    enable = true;
  };
  home.file = {
    ".config/starship.toml".source = ./starship.toml;
  };
}
