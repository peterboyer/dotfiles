{ user, pkgs, ... }:

{
	imports = [
		/etc/nixos/hardware-configuration.nix
	];

	system.stateVersion = "23.11";
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	nixpkgs.config.allowUnfree = true;

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	time.timeZone = "Australia/Sydney";
	i18n.defaultLocale = "en_AU.UTF-8";
	i18n.extraLocaleSettings = {
	  LC_ADDRESS = "en_AU.UTF-8";
	  LC_IDENTIFICATION = "en_AU.UTF-8";
	  LC_MEASUREMENT = "en_AU.UTF-8";
	  LC_MONETARY = "en_AU.UTF-8";
	  LC_NAME = "en_AU.UTF-8";
	  LC_NUMERIC = "en_AU.UTF-8";
	  LC_PAPER = "en_AU.UTF-8";
	  LC_TELEPHONE = "en_AU.UTF-8";
	  LC_TIME = "en_AU.UTF-8";
	};

	networking.hostName = "self";
	networking.networkmanager.enable = true;

	services.xserver.enable = true;
	services.xserver.xkb.layout = "us";
	services.xserver.displayManager.sddm.enable = true;
	services.xserver.desktopManager.plasma5.enable = true;

	services.openssh.enable = true;
	services.printing.enable = true;
	hardware.bluetooth.enable = true;

	sound.enable = true;
	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
	  enable = true;
	  alsa.enable = true;
	  alsa.support32Bit = true;
	  pulse.enable = true;
	};

	environment.shells = with pkgs; [ zsh ];
	users.defaultUserShell = pkgs.zsh;
	programs.zsh.enable = true;
	programs.zsh.ohMyZsh.enable = true;

	users.users.${user} = {
		shell = pkgs.zsh;
		isNormalUser = true;
		extraGroups = [ "networkmanager" "wheel" ];
	};

	virtualisation.docker = {
		enable = true;
		rootless = {
			enable = true;
			setSocketVariable = true;
		};
	};
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

	environment.systemPackages = with pkgs; [
		git
		gcc
		vim
		htop
		killall
		xclip
	];
}
