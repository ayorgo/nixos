{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  };

  outputs = inputs@{ nixpkgs, ... }: {
    nixosConfigurations = {
      tuxedo-intel = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/tuxedo-intel/configuration.nix
        ];
      };
    };
  };
}
