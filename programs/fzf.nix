{ lib, pkgs, config, ... }:

{
  programs.fzf = {
    enable = true;
    # fd is configured in fd.nix but the options have to be duplicated here
    # due to neither bash nor zsh alias expending not being performant enough.
    # E.g. `zsh -lic fd` does the trick but has a noticable lag.
    # ~/.config/fd/ignore is respected though.
    defaultCommand = "fd --no-ignore --hidden --exclude .git";
    defaultOptions = [
      "--height 40%"
      "--border"
      "--gutter ' '"
    ];
  };
}

