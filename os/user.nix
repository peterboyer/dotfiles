{ user, pkgs, ... }:

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
		packages = with pkgs; [
			# import ../../modules/fonts/berkeley-mono.nix
			# (nerdfonts.override { fonts = [ "Berkeley Mono" ]; })
		];
		fontconfig = {
			defaultFonts = {
				emoji = [ "OpenMoji Color" ];
				# monospace = [ "Berkeley Mono" ];
			};
		};
	};
}
