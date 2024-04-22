{ lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Georgios Adzhygai";
    userEmail = "ayorgo@users.noreply.github.com";
    package = pkgs.gitFull;
  };
}
