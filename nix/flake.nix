{
	inputs = {
		nixpkgs = {
			url = "github:nixos/nixpkgs/nixos-23.11";
		};

		nix-darwin = {
			url = "github:LnL7/nix-darwin";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		home-manager = {
			url = "github:nix-community/home-manager/release-23.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, nix-darwin, home-manager, ... }@inputs: let
		system = "x86_64-linux";
		pkgs = nixpkgs.legacyPackages.${system};
	in {
		nixosConfigurations.home = let
			user = "self";
		in nixpkgs.lib.nixosSystem {
			inherit system;
			specialArgs = { inherit user; inherit inputs; };
			modules = [
				./hosts/home/configuration.nix
				home-manager.nixosModules.home-manager {
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
					home-manager.users.${user} = import ./profiles/home/user.nix;
					home-manager.extraSpecialArgs = { inherit user; };
				}
			];
		};

		darwinConfigurations.work = let
			user = "peterboyer";
		in nix-darwin.lib.darwinSystem {
			specialArgs = { inherit user; inherit inputs; };
			modules = [
				home-manager.nixosModules.home-manager {
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
					home-manager.users.${user} = import ./profiles/work/user.nix;
					home-manager.extraSpecialArgs = { inherit user; };
				}
			];
		};
	};
}
