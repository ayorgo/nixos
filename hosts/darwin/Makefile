.PHONY: install
install:
	@sudo nix run nix-darwin/nix-darwin-25.05#darwin-rebuild -- switch --flake .#simple-darwin

.PHONY: rebuild
rebuild:
	@sudo darwin-rebuild switch --flake .#simple-darwin --show-trace

.PHONY: collect-garbage
collect-garbage:
	@sudo nix-collect-garbage -d \
	&& nix-collect-garbage -d

.PHONY: update
update:
	@nix flake update --extra-experimental-features "nix-command flakes"

.PHONY: nix-daemon
nix-daemon:
	@sudo launchctl bootout system/org.nixos.nix-daemon \
	&& sleep 1 \
	&& sudo launchctl bootstrap system /Library/LaunchDaemons/org.nixos.nix-daemon.plist
