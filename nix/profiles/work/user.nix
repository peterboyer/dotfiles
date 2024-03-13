{ user, ... }:

{
	home.username = "${user}";
	home.homeDirectory = "/Users/${user}";
	home.stateVersion = "23.11";

	imports = [
		../../modules/shell.nix
		../../modules/programs/kitty.nix
		../../modules/programs/lazygit.nix
		../../modules/programs/tmux.nix
		../../modules/programs/neovim.nix
	];
}
