{ host, user, pkgs, ... }:
let packages = (import ./packages.nix) pkgs; in
{
	nixpkgs.config.allowUnfree = true;

	system.stateVersion = "23.11";
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	networking.hostName = host;
	networking.networkmanager.enable = true;

	environment.shells = with pkgs; [ packages.shell ];
	environment.systemPackages = packages.sys;
	programs.zsh.enable = true;
	programs.zsh.ohMyZsh.enable = true;

	services.xserver.enable = true;
	services.xserver.xkb.layout = "us";
	services.xserver.xkb.options = "terminate:ctrl_alt_bksp,caps:ctrl_modifier";
	services.xserver.displayManager.sddm.enable = true;
	services.xserver.desktopManager.plasma5.enable = true;

	services.openssh = {
		enable = true;
		ports = [ 23 ];
		settings = {
			PasswordAuthentication = false;
			AllowUsers = [ user ];
			UseDns = true;
			X11Forwarding = false;
			PermitRootLogin = "no";
		};
		authorizedKeysFiles = [
			"/home/${user}/.ssh/authorized_keys"
		];
	};
	services.endlessh = {
		enable = true;
		port = 22;
	};

	services.printing.enable = true;
	hardware.bluetooth.enable = true;

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

	sound.enable = true;
	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
	  enable = true;
	  alsa.enable = true;
	  alsa.support32Bit = true;
	  pulse.enable = true;
	};

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
}
