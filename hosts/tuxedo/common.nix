{ lib, pkgs, ... }:

let
  OAuth2Settings = id: {
    "mail.smtpserver.smtp_${id}.authMethod" = 10;
    "mail.server.server_${id}.authMethod" = 10;
  };
in
{
  imports = [
    ./programs/bash
    ./programs/emacs
    ./programs/librewolf
    ./programs/git.nix
    ./programs/lsd.nix
    ./programs/neovim
    ./programs/starship
    ./services/watch-gnome-theme.nix
    ../../programs/anki.nix
    ../../programs/gnome.nix
    ../../programs/kitty.nix
  ];

  home.username = "ayorgo";
  home.homeDirectory = "/home/ayorgo";

  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    freetube
    fastfetch
    fzf
    ripgrep
    fd
    texlive.combined.scheme-full
    rnote # sketching and handwritten note taking
    httpie
    awscli2
    unzip
    docker-compose
    vlc
    masterpdfeditor4
    evolution
    gdu  # disk usage analyser
    superTuxKart  # a fun FOSS racing game
    tor-browser
    yazi
    ffmpeg
    libreoffice
    brave
    zoom-us
    pyright
  ];

  accounts.email.accounts = {
    gmail = {
      primary = true;
      flavor = "gmail.com";
      address = "george.adzhygai@gmail.com";
      realName = "Georgios Adzhygai";
      smtp.tls.useStartTls = true;
      thunderbird = {
        enable = true;
        settings = OAuth2Settings;
      };
    };
  };
}
