{
	inputs = {
		nixpkgs = {
			url = "github:nixos/nixpkgs/nixos-23.11";
		};
		nixpkgs-unstable = {
			url = "github:nixos/nixpkgs/nixos-unstable";
		};
	};

	outputs = { nixpkgs, nixpkgs-unstable, ... }: let
		system = "x86_64-linux";
		overlay-unstable = final: prev: {
			unstable = import nixpkgs-unstable {
				inherit system;
				config.allowUnfree = true;
			};
		};
		overlay-custom = final: prev: {
			custom = pkgs: {
				youtube-dl = (import ../pkgs/youtube-dl { inherit pkgs; });
			};
		};
	in {
		nixosConfigurations.home = let
			user = "self";
			host = "self";
		in nixpkgs.lib.nixosSystem {
			inherit system;
			specialArgs = {
				inherit host;
				inherit user;
			};
			modules = [
				# pkgs.unstable => nixpkgs-unstable
				({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable overlay-custom ]; })
				./host.nix
				./user.nix
				/etc/nixos/hardware-configuration.nix
			];
		};
	};
}
