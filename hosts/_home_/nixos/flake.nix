{
	inputs = {
		nixpkgs = {
			url = "github:nixos/nixpkgs/nixos-24.05";
		};
		nixpkgs-unstable = {
			url = "github:nixos/nixpkgs/nixos-unstable";
		};
		nixpkgs-pinned = {
			url = "github:nixos/nixpkgs/12bf09802d77264e441f48e25459c10c93eada2e";
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
