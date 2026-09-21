{ lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    settings.user = {
      name = "Georgios Adzhygai";
      email = "ayorgo@users.noreply.github.com";
    };
  };
}
