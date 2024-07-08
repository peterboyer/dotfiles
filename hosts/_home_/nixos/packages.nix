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

		# https://www.qualys.com/2024/07/01/cve-2024-6387/regresshion.txt
		# https://discourse.nixos.org/t/security-advisory-openssh-cve-2024-6387-regresshion-update-your-servers-asap/48220
		pkgs-unstable.openssh
	];

	user = [
		eza
		fzf

		tmux
		neovim
		ripgrep
		trash-cli
		nodejs_22
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
		pdfgrep

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
		gparted

		pkgs-custom.youtube-dl
	];
}
