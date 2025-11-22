# Installed through Homebrew
# https://github.com/nix-darwin/nix-darwin/issues/1041
{
  home.file.".config/karabiner/karabiner.json" = {
    source = ./karabiner.json;
  };
}
