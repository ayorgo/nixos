{ lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Georgios Adzhygai";
    userEmail = "georgios.adzhygai@example.com";
    package = pkgs.gitFull;
    extraConfig = {
      # http.sslverify = false; # just to be able to install homebrew
    };
  };
}
