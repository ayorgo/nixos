{ lib, pkgs, user, ... }:

{
  home.username = user.name;
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    btop
    coreutils
    fastfetch
    httpie
    ripgrep
    unzip
    devcontainer
    (google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.gke-gcloud-auth-plugin])
    docker
    docker-compose
    docker-credential-helpers
    docker-buildx
    colima
    kubectl
    mpv
    just
    yq
    nixfmt
    texlive.combined.scheme-full
    texlivePackages.minted
    python313Packages.pygments
    ty
    visidata
    mermaid-cli
    rustup
    gemini-cli
    tree
    # qobuz-player
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
    # EDITOR = "nvim";  # done inside the Neovim config
    MANPAGER = "nvim +Man! --clean -c 'set ignorecase smartcase so=999'";
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
