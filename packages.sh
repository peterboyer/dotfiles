#!/bin/bash

PACKAGES=(
	openssh
	udisks2

	acpid
		brightnessctl
	bluez
		bluez-utils
	pipewire
		pipewire-alsa
		pipewire-pulse
		pipewire-jack
		wireplumber

	zsh
		tmux
		oh-my-zsh-git
		exa
		p7zip
		ranger
		neofetch

	git
		lazygit

	nvm
	neovim
		ripgrep

	docker
		docker-compose

	ttf-font-awesome
	ttf-jetbrains-mono

	xorg
	xorg-xinit
	xorg-xrandr
	awesome
	autorandr

	kitty
	brave-bin

	# xclip
	# slock
	# xautolock
	# calc
	# peek
	# xcolor
	# flameshot
	# gimp
	# pdfarranger
	# signal-desktop
	# flyctl-bin
	# spotify
	# ntfs-3g
	# ifuse
	# nemo
	# gthumb
	# vlc
	# v4l2loopback-dkms
	# gphoto2
	# obs-studio
	# obs-linuxbrowser-bin
	# joyutils
	# cmatrix
	# slides-bin
	# insomnia-bin
)

yay -S --needed ${PACKAGES[@]}

# acpid
systemctl enable acpid --now

# bluetooth
systemctl enable bluetooth --now

# nvm
source /usr/share/nvm/init-nvm.sh
nvm install --lts
npm install -g yarn

# docker
sudo usermod -aG docker $USER
sudo systemctl enable docker --now

# kitty
git clone git@github.com:dexpota/kitty-themes.git ~/.config/kitty/kitty-themes
