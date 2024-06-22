{
	inputs = {
		nixpkgs = {
			url = "github:nixos/nixpkgs/nixos-24.05";
		};
		nixpkgs-unstable = {
			url = "github:nixos/nixpkgs/nixos-unstable";
		};
	};

	outputs = { nixpkgs, nixpkgs-unstable, ... }:
	let
		system = "x86_64-linux";
		options = { inherit system; config.allowUnfree = true; };
		pkgs = import nixpkgs options;
		pkgs-unstable = import nixpkgs-unstable options;
		pkgs-custom = import ./pkgs-custom pkgs;
	in
	{
		nixosConfigurations.default = nixpkgs.lib.nixosSystem {
			inherit system;
			specialArgs = {
				inherit pkgs-unstable;
				inherit pkgs-custom;
			};
			modules = [
				./hardware-configuration.nix
				./configuration.nix
			];
		};
	};
}
