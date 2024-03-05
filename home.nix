{ config, pkgs, ... }:

{
	home.username = "self";
	home.homeDirectory = "/home/self";
	home.stateVersion = "23.11";

	home.packages = with pkgs; [
		kitty
		tmux
		lazygit
		trash-cli
		neovim
		brave
	];

	home.file = let
		DOTFILES = "${config.home.homeDirectory}/_/dotfiles";
	in with config.lib.file; {
			".tmux.conf".source = mkOutOfStoreSymlink "${DOTFILES}/tmux/tmux.conf";
			".config/nvim".source = mkOutOfStoreSymlink "${DOTFILES}/nvim";
			".config/lazygit".source = mkOutOfStoreSymlink "${DOTFILES}/lazygit";
	};

	programs.git = {
		enable = true;
		userName = "Peter Boyer";
		userEmail = "8391902+peterboyer@users.noreply.github.com";
	};

	programs.zsh = {
		enable = true;
	};

	programs.home-manager.enable = true;
}
