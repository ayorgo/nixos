# For the icon fonts to work, run M-x nerd-icons-install-fonts. It's built into doom and will install icon fonts into a local writable directory.
{ lib, pkgs, config, ... }:

{
  services.emacs.enable = true;
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;  # works best with wayland
  };
  home = {
    packages = with pkgs; [
      hunspell
      hunspellDicts.ru-ru
      hunspellDicts.en-us-large
      hunspellDicts.en-gb-large
    ];
    sessionPath = [ "home/ayorgo/emacs/bin" "home/ayorgo/.emacs.d/bin" "${pkgs.emacs}/bin" "${pkgs.git}" ];
    sessionVariables = {
      DOOMDIR = "/home/ayorgo/.doom.d";
      DOOMLOCALDIR = "/home/ayorgo/doom-emacs";
      DOOMPROFILELOADFILE="~/doom-emacs/load.el";
    };
    file = {
      ".emacs.d" = {
        source = builtins.fetchGit {
          url = "https://github.com/doomemacs/doomemacs";
          ref = "master";
          rev = "5020d592dafc666cee259c8463f2e304826858d1";
          shallow = true;
        };
        onChange = "${pkgs.writeShellScript "doom-change" ''
          export DOOMDIR="${config.home.sessionVariables.DOOMDIR}"
          export DOOMLOCALDIR="${config.home.sessionVariables.DOOMLOCALDIR}"
          export PATH="$PATH:${pkgs.emacs}/bin"
          export PATH="$PATH:${pkgs.git}/bin"
          export PATH="$PATH:${pkgs.ripgrep}/bin"
          export PATH="$PATH:${pkgs.fd}/bin"
          export PATH="$PATH:${pkgs.sqlite}/bin"
          export DOOMPROFILELOADFILE="~/doom-emacs/load.el";
          if [ ! -d "$DOOMLOCALDIR" ]; then
            /home/ayorgo/.config/emacs/bin/doom --force install
          else
            /home/ayorgo/.config/emacs/bin/doom --force clean
            /home/ayorgo/.config/emacs/bin/doom --force sync -u
          fi
        ''}";
      };
      "${config.home.sessionVariables.DOOMDIR}/config.el" = lib.mkDefault {
        source = ./config.el;
      };
      "${config.home.sessionVariables.DOOMDIR}/init.el" = {
        source = ./init.el;
      };
      "${config.home.sessionVariables.DOOMDIR}/packages.el" = {
        source = ./packages.el;
      };
    };
  };
}

