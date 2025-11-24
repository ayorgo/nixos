{ lib, pkgs, config, ... }:

{
  # The service doesn't seem to be working on MacOS
  # services.emacs.enable = true;
  programs.emacs = {
    enable = true;
    package = pkgs.emacs30.override {
      withSQLite3 = true;
      withWebP = true;
      withImageMagick = true;
      withTreeSitter = true;
    };
  };
  home = {
    packages = with pkgs; [
      hunspell
      hunspellDicts.en-us-large
      hunspellDicts.en-gb-large
    ];
    file = {
      ".emacs.d/init.el" = {
        source = ./init.el;
      };
    };
  };
}
