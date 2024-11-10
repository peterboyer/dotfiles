{
	inputs = {
		nixpkgs = {
			url = "github:nixos/nixpkgs/nixos-24.05";
		};
		nixpkgs-unstable = {
			url = "github:nixos/nixpkgs/nixos-unstable";
		};
		nixpkgs-pinned = {
			url = "github:nixos/nixpkgs/83fb6c028368e465cd19bb127b86f971a5e41ebc";
		};
	};

	outputs = { nixpkgs, nixpkgs-unstable, nixpkgs-pinned, ... }:
	let
		system = "x86_64-linux";
		options = { inherit system; config.allowUnfree = true; };
		pkgs = import nixpkgs options;
		pkgs-unstable = import nixpkgs-unstable options;
		pkgs-pinned = import nixpkgs-pinned options;
	in
	{
		nixosConfigurations.default = nixpkgs.lib.nixosSystem {
			inherit system;
			specialArgs = {
				pkgs-unstable = pkgs-unstable;
				pkgs-custom = import ./pkgs-custom pkgs-pinned;
			};
			modules = [
				./hardware-configuration.nix
				./configuration.nix
			];
		};
	};
}
