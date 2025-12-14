.PHONY: home-dark
home-dark:
	home-manager switch --flake ./flavours/dark

.PHONY: home-light
home-light:
	home-manager switch --flake ./flavours/light

.PHONY: rebuild-host
rebuild-host:
	sudo nixos-rebuild switch --flake './hosts#tuxedo'

.PHONY: rebuild-dark
rebuild-dark: rebuild-host home-dark

.PHONY: rebuild-light
rebuild-light: rebuild-host home-light

.PHONY: update
update:
	nix flake update
	(cd ~/pet/nixos/hosts/tuxedo/flavours/dark/ && nix flake update)
	(cd ~/pet/nixos/hosts/tuxedo/flavours/light/ && nix flake update)

.PHONY: collect-garbage
collect-garbage:
	nix-collect-garbage --delete-old
	sudo nix-collect-garbage --delete-old
