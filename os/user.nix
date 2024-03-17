{ user, inputs, pkgs, ... }:

{
	users.users.${user} = with pkgs; {
		shell = zsh;
		isNormalUser = true;
		extraGroups = [ "networkmanager" "wheel" ];
		packages = (import ./user.packages.nix) pkgs;
	};

	virtualisation.docker.enable = true;
	users.extraGroups.docker.members = [ "${user}" ];

	fonts = {
		fontconfig = {
			defaultFonts = {
				emoji = [ "OpenMoji Color" ];
				monospace = [ "BerkeleyMono Nerd Font Mono" ]; # linked by dotbot
			};
		};
		packages = [
			pkgs.openmoji-color
		];
	};
}
