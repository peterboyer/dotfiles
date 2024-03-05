{
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
		home-manager.url = "github:nix-community/home-manager/release-23.11";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs = { self, nixpkgs, home-manager, ... }@inputs: {
		nixosConfigurations.self = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			specialArgs = { inherit inputs; };
			modules = [
				/etc/nixos/hardware-configuration.nix
				./configuration.nix
				home-manager.nixosModules.home-manager {
					home-manager.useUserPackages = true;
					home-manager.useGlobalPkgs = true;
					home-manager.users.self = import ./home.nix;
				}
			];
		};
	};
}
