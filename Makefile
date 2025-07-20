.PHONY: home-dark
home-dark:
	home-manager switch --flake ./home/flavours/dark

.PHONY: home-light
home-light:
	home-manager switch --flake ./home/flavours/light

.PHONY: hosts-tuxedo
hosts-tuxedo:
	sudo nixos-rebuild switch --flake './hosts#tuxedo'
