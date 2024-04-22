{ lib, pkgs, ... }:

{
  systemd.user.services.watch-gnome-theme = {
    Unit = {
      Description = "Watch GNOME Theme Changes";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      Restart = "always";
      ExecStart = "${pkgs.writeShellScript "watch-gnome-theme" ''
        #!/run/current-system/sw/bin/bash
        dconf watch "/org/gnome/desktop/interface/color-scheme" | while read value; do
          if [[ "$value" == "'prefer-dark'" ]]; then
            home-manager switch --flake ~/pet/nixos/home/flavours/dark && nvr -c 'AirlineTheme dark' --nostart -s && nvr -c 'set background=dark' --nostart -s
          fi
          if [[ "$value" == "'default'" ]]; then
            home-manager switch --flake ~/pet/nixos/home/flavours/light && nvr -c 'AirlineTheme sol' --nostart -s && nvr -c 'set background=light' --nostart -s
          fi
        done
      ''}";
    };
  };
}
