{ lib, pkgs, config, ... }:

{
  programs.fd = {
    enable = true;
    extraOptions = [
      "--no-ignore"
      "--hidden"
      "--exclude" ".git"
    ];
  };
}
