# For the icon fonts to work, run M-x nerd-icons-install-fonts. It's built into doom and will install icon fonts into a local writable directory.
{ lib, pkgs, config, ... }:

{
  # services.emacs = {
  #   enable = true;
  #   package = pkgs.emacs-pgtk;
  # };
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
      treemacs
      treemacs-evil
      treemacs-projectile
      treemacs-icons-dired
      treemacs-persp
      treemacs-tab-bar
      catppuccin-theme
      nix-ts-mode
      dockerfile-mode
      markdown-mode
    #   dante
    ]);
  };

  # `init.el` is copied by the flavours 
  # home.file.".emacs.d/init.el".source = ./init.el;
}
