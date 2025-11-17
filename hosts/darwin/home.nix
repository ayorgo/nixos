{ lib, pkgs, ... }:

{
  home.username = "ayorgo";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    btop
    coreutils
    fastfetch
    fd
    fzf
    httpie
    ripgrep
    source-code-pro
    unzip
  ];
  imports = [
    ./programs/emacs
    ./programs/git.nix
    ./programs/kitty
    ./programs/librewolf
    ./programs/lsd.nix
    ./programs/neovim
    ./programs/starship
    ./programs/zsh
  ];
  home.sessionVariables = {
    EDITOR = "nvim";
    MOZ_LEGACY_PROFILES = "1";
  };
  home.file.".config/nvim/bg".text = "light";
}
