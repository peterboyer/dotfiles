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
		usbimager
		appimage-run

		# 8.5p1 <= OpenSSH < 9.8p1 is vulnerable.
		# https://www.qualys.com/2024/07/01/cve-2024-6387/regresshion.txt
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
		rustup
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
		rar
		p7zip
		ffmpeg

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
		gimp
		pdfarranger
		audacity
		blender
		obs-studio
		remmina
		moonlight-qt
		typora
		gparted
		libreoffice
		wireshark
		telegram-desktop
		ventoy

		android-tools

		pkgs-custom.godot
		pkgs-custom.youtube-dl
	];
}
