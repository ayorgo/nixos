# For the icon fonts to work, run M-x nerd-icons-install-fonts. It's built into doom and will install icon fonts into a local writable directory.
{ lib, pkgs, config, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    # package = pkgs.emacs-pgtk.override {
    #   withSQLite3 = true;
    #   withWebP = true;
    #   withImageMagick = true;
    #   withTreeSitter = true;
    #   withNativeCompilation = true;
    # };
    extraPackages = epkgs: (with epkgs; [
      treesit-grammars.with-all-grammars
      use-package
      eat
      centered-cursor-mode
    ]) ++ (with epkgs.melpaStablePackages; [
      magit
      yaml-mode
      json-mode
    ]) ++ (with epkgs.melpaPackages; [
      evil
      evil-collection
      undo-fu
      nix-ts-mode
      dockerfile-mode
      markdown-mode
      doom-themes
    #   dante
    ]);
  };

  # `init.el` is copied by the flavours 
  # home.file.".emacs.d/init.el".source = ./init.el;
}
