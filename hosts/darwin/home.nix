{ lib, pkgs, user, ... }:

{
  home.username = user.name;
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    btop
    coreutils
    fastfetch
    fd
    fzf
    httpie
    ripgrep
    unzip
  ];
  imports = [
    ./programs/emacs
    ./programs/git.nix
    ./programs/kitty.nix
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
  home.activation = {
    defaultBrowser = (lib.hm.dag.entryAfter ["installPackages"] ''
      run echo "Setting default browser to librewolf"
      run ${pkgs.defaultbrowser}/bin/defaultbrowser librewolf
    '');
  };
  home.file.".config/nvim/bg".text = "light";
}
