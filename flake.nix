{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = inputs@{ nixpkgs, ... }: {
    nixosConfigurations = {
      tuxedo = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/tuxedo/configuration.nix
        ];
      };
    };
  };
}
