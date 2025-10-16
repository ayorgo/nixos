{ lib, pkgs, config, ... }:

{
  programs.lsd = {
    enable = true;
    enableBashIntegration = true;

    # https://github.com/lsd-rs/lsd/tree/v1.0.0#color-theme-file-content
    colors = {
      user = "dark_yellow";
      size = {
        large = "dark_yellow";
        small = "dark_yellow";
      };
    };
  };
}

