{ lib, pkgs, user, ... }:

{
  home.username = user.name;
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    btop
    coreutils
    fastfetch
    httpie
    ripgrep
    unzip
    docker
    docker-compose
    docker-credential-helpers
    colima
    mpv
    nixfmt
    ty
  ];
  imports = [
    ../../programs/emacs
    ../../programs/fd.nix
    ../../programs/fzf.nix
    ../../programs/git.nix
    ../../programs/kitty.nix
    ../../programs/firefox
    ../../programs/lsd.nix
    ../../programs/neovim
    ../../programs/starship
    ../../programs/zsh
    ../../programs/karabiner-elements
  ];
  home.sessionVariables = {
    EDITOR = "nvim";
    MOZ_LEGACY_PROFILES = "1";
  };
  home.activation = {
    defaultBrowser = (lib.hm.dag.entryAfter ["installPackages"] ''
      run echo "Setting default browser to firefox"
      run ${pkgs.defaultbrowser}/bin/defaultbrowser firefox
    '');
  };
  home.file.".config/nvim/bg".text = "light";
}
