{ pkgs, ... }@args:
let
	host = "self";
	user = "self";
	packages = (import ./packages.nix) args;
in
{
	networking.hostName = host;
	networking.networkmanager.enable = true;

	nixpkgs.config.allowUnfree = true;
	environment.systemPackages = packages.system;
	virtualisation.docker.enable = true;

	programs.zsh.enable = true;
	programs.zsh.ohMyZsh.enable = true;

	users = {
		defaultUserShell = pkgs.zsh;
		users.${user} = {
			isNormalUser = true;
			extraGroups = [ "wheel" "networkmanager" "docker" ];
			packages = packages.user;
		};
	};

	services.displayManager.sddm.enable = true;
	services.desktopManager.plasma6.enable = true;
	services.xserver = {
		enable = true;
		xkb.layout = "us";
		xkb.options = "terminate:ctrl_alt_bksp,caps:ctrl_modifier";
	};

	services.printing.enable = true;
	hardware.bluetooth.enable = true;

	services.openssh = {
		enable = true;
		settings = {
			UseDns = true;
			AllowUsers = [ user ];
			PermitRootLogin = "no";
			PasswordAuthentication = false;
		};
		authorizedKeysFiles = [
			"/home/${user}/.ssh/authorized_keys"
		];
	};

	fonts = {
		fontconfig = {
			defaultFonts = {
				emoji = [ "OpenMoji Color" ];
				monospace = [ "BerkeleyMono Nerd Font Mono" ];
			};
		};
		packages = [
			pkgs.openmoji-color
		];
	};

	sound.enable = true;
	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
	  enable = true;
	  alsa.enable = true;
	  alsa.support32Bit = true;
	  pulse.enable = true;
	};

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

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	system.stateVersion = "23.11";
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
