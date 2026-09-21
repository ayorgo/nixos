.PHONY: home
rebuild:
	nix run github:nix-community/home-manager -- switch --flake .#android

.PHONY: update
update:
	nix flake update
	(cd ~/diy/nixos/hosts/tuxedo/flavours/dark/ && nix flake update)
	(cd ~/diy/nixos/hosts/tuxedo/flavours/light/ && nix flake update)

.PHONY: collect-garbage
collect-garbage:
	nix-collect-garbage --delete-old
