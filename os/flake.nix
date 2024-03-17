{
	inputs = {
		nixpkgs = {
			url = "github:nixos/nixpkgs/nixos-23.11";
		};

		# mypkgs = {
		#   url = "./modules/mypkgs";
		#   inputs.nixpkgs.follows = "nixpkgs";
		# };
	};

	outputs = { self, nixpkgs, ... }@inputs: {
		nixosConfigurations.home = let
			user = "self";
			host = "self";
		in nixpkgs.lib.nixosSystem {
			specialArgs = {
				inherit host;
				inherit user;
				inherit inputs;
			};
			modules = [
				./host.nix
				./user.nix
				/etc/nixos/hardware-configuration.nix
			];
		};
	};
}
