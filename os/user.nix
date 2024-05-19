{ user, pkgs, ... }:
let packages = (import ./packages.nix) pkgs; in
{
	users.users.${user} = {
		shell = packages.shell;
		isNormalUser = true;
		extraGroups = [ "networkmanager" "wheel" ];
		packages = packages.user;
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
