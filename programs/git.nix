{ lib, pkgs, ... }:

{
  programs = {
    git = {
      enable = true;
      package = pkgs.gitFull;
    };

    ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks."*" = {
        forwardAgent = false;
        addKeysToAgent = "no";
        compression = false;
        serverAliveInterval = 0;
        serverAliveCountMax = 3;
        hashKnownHosts = false;
        userKnownHostsFile = "~/.ssh/known_hosts";
        controlMaster = "no";
        controlPath = "~/.ssh/master-%r@%n:%p";
        controlPersist = "no";
      };
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
