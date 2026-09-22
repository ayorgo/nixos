{
  lib,
  pkgs,
  config,
  ...
}:

{
  # The service doesn't seem to be working on MacOS.
  # It's not that useful on Linux either.
  services.emacs.enable = false;
  programs.emacs = {
    enable = true;
    package = lib.mkMerge [
      (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin (
        pkgs.emacs.override {
          withSQLite3 = true;
          withWebP = true;
          withImageMagick = true;
          withTreeSitter = true;
        }
      ))
      (lib.mkIf pkgs.stdenv.hostPlatform.isLinux pkgs.emacs-pgtk)
    ];
  };
  home = {
    packages = with pkgs; [
      hunspell
      hunspellDicts.en-us-large
      hunspellDicts.en-gb-large
    ];
    # On Tuxedo Linux `init.el` is copied by the flavours
    file = lib.mkMerge [
      (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
        ".emacs.d/init.el" = {
          source = ./init.el;
        };
      })
    ];
  };
}
