# For the icon fonts to work, run M-x nerd-icons-install-fonts. It's built into doom and will install icon fonts into a local writable directory.
{ lib, pkgs, config, ... }:

{
  # services.emacs = {
  #   enable = true;
  #   package = pkgs.emacs-pgtk;
  # };
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk.override {
      withSQLite3 = true;
      withWebP = true;
      withImageMagick = true;
      withTreeSitter = true;
    };
  };

  home.file.".emacs.d/init.el".source = ./init.el;
}
