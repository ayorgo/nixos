# nixos-config
## System configuration
```sh
sudo nixos-rebuild switch --flake ~/pet/nixos/hosts#tuxedo
```

## Home configuration
```sh
home-manager switch --flake ~/pet/nixos/home/dark
```
```sh
home-manager switch --flake ~/pet/nixos/home/light
```
### Theme toggle
I made the above commands (plus some other stuff) run by a service that watches the `dconf` `color-scheme` key change:
