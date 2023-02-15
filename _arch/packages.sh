#!/bin/bash

PACKAGES=(
	exa
	ranger
	ripgrep
	lazygit
	oh-my-zsh-git

	nvm
	docker
	docker-compose

	p7zip
	ttf-jetbrains-mono

	brave-bin

	# xclip
	# autorandr
	# slock
	# xautolock
	# kitty
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
	# AUR:obs-linuxbrowser-bin
	# joyutils
	# cmatrix
	# slides-bin
	# insomnia-bin
)

yay -S --needed --noconfirm ${PACKAGES[@]}

# nvm
source /usr/share/nvm/init-nvm.sh
nvm install --lts

# docker
sudo usermod -aG docker $USER
sudo systemctl enable docker --now
