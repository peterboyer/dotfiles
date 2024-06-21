{ pkgs, pkgs-unstable, pkgs-custom, ... }:
with pkgs;
{
	system = [
		gcc
		vim
		git
		wget
		htop
		sshfs
		unzip
		xclip
		killall
		envsubst
		neofetch
	];

	user = [
		eza
		fzf

		tmux
		neovim
		ripgrep
		trash-cli
		nodejs_21
		cargo
		pkgs-unstable.lazygit
		kitty

		jq
		calc
		qrencode
		cmatrix
		dotbot
		dive
		slides
		ngrok
		nebula
		imagemagick

		monolith

		firefox
		brave
		discord
		slack
		signal-desktop
		spotify
		vlc
		flameshot
		peek
		colorpicker
		pdfarranger
		audacity
		blender
		obs-studio
		remmina
		moonlight-qt
		typora

		pkgs-custom.youtube-dl
	];
}
