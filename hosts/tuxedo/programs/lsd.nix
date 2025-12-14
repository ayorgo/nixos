{ lib, pkgs, config, ... }:

{
  programs.lsd = {
    enable = true;
    enableBashIntegration = true;

    settings = {
      blocks = ["permission" "user" "size" "date" "name"];
      total-size = false;  # turn off to avoid Permission denied errors on root owned directories
      date = "+%Y-%m-%d %H:%M:%S %z";
    };
    # https://github.com/lsd-rs/lsd/tree/v1.0.0#color-theme-file-content
    colors = {
      user = "dark_yellow";
      size = {
        none = "blue";
        small = "blue";
        medium = "blue";
        large = "blue";
      };
      date = {
        hour-old = "green";
        day-old = "green";
        older = "green";
      };
    };
  };
}
