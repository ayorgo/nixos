# For the icon fonts to work, run M-x nerd-icons-install-fonts. It's built into doom and will install icon fonts into a local writable directory.
{ lib, pkgs, config, ... }:

{
  # The service doesn't seem to be working on MacOS
  # services.emacs.enable = true;
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-30.override {
      withSQLite3 = true;
      withWebP = true;
      withImageMagick = true;
      withTreeSitter = true;

      # A hotfix for MacOS 15.4
      # https://github.com/NixOS/nixpkgs/issues/395169
      withNativeCompilation = false;
    };
    extraPackages = epkgs: (with epkgs; [
      treesit-grammars.with-all-grammars
      use-package
      eat
      centered-cursor-mode
      evil-commentary
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
    # extraConfig = lib.mkDefault (builtins.readFile ./init.el);
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
