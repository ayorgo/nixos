{ lib, pkgs, ... }:

let
  OAuth2Settings = id: {
    "mail.smtpserver.smtp_${id}.authMethod" = 10;
    "mail.server.server_${id}.authMethod" = 10;
  };
in
{
  imports = [
    ./programs/anki.nix
    ./programs/bash.nix
    ./programs/emacs/emacs.nix
    ./programs/librewolf.nix
    ./programs/git.nix
    ./programs/gnome.nix
    ./programs/kitty.nix
    ./programs/neovim/neovim.nix
    ./services/watch-gnome-theme.nix
  ];

  home.username = "ayorgo";
  home.homeDirectory = "/home/ayorgo";

  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    spotify
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
    lsd  # better ls
    superTuxKart  # a fun FOSS racing game
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
