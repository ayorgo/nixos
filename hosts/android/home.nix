{ pkgs, ... }:

{
  imports = [
    ./programs/git.nix
    ../../programs/fd.nix
    ../../programs/fzf.nix
    ../../programs/neovim
    ../../programs/pandoc
  ];

  home.username = "droid";
  home.homeDirectory = "/home/droid";

  home.stateVersion = "26.05";

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    gnumake
    home-manager
    fastfetch
    ripgrep
    fd
  ];
}
