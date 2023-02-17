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
		autorandr
	awesome
	nemo
		nemo-fileroller
		nemo-preview

	ntfs-3g
	ifuse

	kitty

	vlc
	spotify
	brave-bin
	signal-desktop

	flyctl-bin
	insomnia-bin

	gimp
	xcolor
	gthumb
	pdfarranger

	peek
	flameshot

	calc
	cmatrix
	slides-bin
	joyutils

	obs-studio
	obs-linuxbrowser-bin
	gphoto2
	v4l2loopback-dkms
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

# nemo
dconf load / <<- "EOF"
	[org/nemo/preferences]
	close-device-view-on-device-eject=true
	date-format='iso'
	default-folder-viewer='list-view'
	enable-delete=false
	inherit-folder-viewer=true
	show-full-path-titles=true
	sort-directories-first=false
	sort-favorites-first=true
EOF
