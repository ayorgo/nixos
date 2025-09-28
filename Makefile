.PHONY: home-dark
home-dark:
	home-manager switch --flake ./home/flavours/dark

.PHONY: home-light
home-light:
	home-manager switch --flake ./home/flavours/light

.PHONY: hosts-tuxedo
hosts-tuxedo:
	sudo nixos-rebuild switch --flake './hosts#tuxedo'

.PHONY: rebuild-dark
rebuild-dark: hosts-tuxedo home-dark

.PHONY: rebuild-light
rebuild-light: hosts-tuxedo home-light

.PHONY: update
update:
	nix flake update
	(cd ~/pet/nixos/home/flavours/dark/ && nix flake update)
	(cd ~/pet/nixos/home/flavours/light/ && nix flake update)

.PHONY: collect-garbage
collect-garbage:
	nix-collect-garbage --delete-old
	sudo nix-collect-garbage --delete-old
