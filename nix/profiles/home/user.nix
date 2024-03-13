{ user, config, pkgs, ... }:

{
	home.username = "${user}";
	home.homeDirectory = "/home/${user}";
	home.stateVersion = "23.11";

	imports = [
		../../modules/shell.nix
		../../modules/programs/kitty.nix
		../../modules/programs/lazygit.nix
		../../modules/programs/tmux.nix
		../../modules/programs/neovim.nix
	];

	home.file = {
		".ssh".source = config.lib.file.mkOutOfStoreSymlink
			"${config.home.homeDirectory}/_/dotfiles.untracked/ssh";
	};

	home.packages = with pkgs; [
		brave
		discord
		slack
		firefox
	];

	programs.home-manager.enable = true;
}
