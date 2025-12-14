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
        dconf watch "/org/gnome/desktop/interface/color-scheme" | while read value; do
          if [[ "$value" == "'prefer-dark'" ]]; then
            emacsclient -e "(load-theme 'doom-one t)"
            home-manager switch --flake ~/pet/nixos/home/flavours/dark
            for filename in ~/.cache/nvim/server-*; do
              nvim --server ''${filename} --remote-send ':set background=dark | AirlineTheme dark<CR>'
            done
          fi
          if [[ "$value" == "'default'" ]]; then
            emacsclient -e "(load-theme 'doom-one-light t)"
            home-manager switch --flake ~/pet/nixos/home/flavours/light
            for filename in ~/.cache/nvim/server-*; do
              nvim --server ''${filename} --remote-send ':set background=light | AirlineTheme sol<CR>'
            done
          fi
        done
      ''}";
    };
  };
}
