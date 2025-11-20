{ lib, pkgs, ... }:

{
  programs = {
    git = {
      enable = true;
      package = pkgs.gitFull;
    };

    ssh = {
      enable = true;

      # SSH client configuration
      extraConfig = ''
        Host github.com
          IdentityFile ~/.ssh/github
          AddKeysToAgent yes

        Host gitlab.kfplc.com
          IdentityFile ~/.ssh/gitlab
          PreferredAuthentications publickey
      '';
    };
  };
}
