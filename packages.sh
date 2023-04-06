#!/bin/bash

# == hardware ==
# sudo zypper install alsa-firmware
# sudo zypper install sof-firmware

# == shell ==
# sudo zypper install zsh
# chsh -s /bin/zsh
# export OMZ_DIR="/usr/share/oh-my-zsh-git" && (
	# sudo git clone https://github.com/ohmyzsh/ohmyzsh.git "$OMZ_DIR"
	# sudo chown -R $USER:$USER $OMZ_DIR
# )
# sudo zypper install exa
# sudo zypper install tmux
# sudo zypper install fzf

# == general ==
# sudo zypper install git
# sudo zypper install neofetch

# == lazygit ==
# export LAZYGIT_DIR="/usr/share/lazygit-bin" && (
	# sudo mkdir -p $LAZYGIT_DIR
	# sudo chown -R $USER:$USER $LAZYGIT_DIR
	# cd "$LAZYGIT_DIR"
	# curl -L https://github.com/jesseduffield/lazygit/releases/download/v0.37.0/lazygit_0.37.0_Linux_x86_64.tar.gz | tar -xz
	# sudo ln -s -t /usr/bin /usr/share/lazygit-bin/lazygit
# )

# == neovim ==
# sudo zypper install neovim
# sudo zypper install gcc # for treesitter
# sudo zypper install gcc-c++ # for treesitter
# sudo zypper install ripgrep # for telescope
# export NVM_DIR="/usr/share/nvm-git" && (
	# sudo git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
	# sudo chown -R $USER:$USER $NVM_DIR
	# cd "$NVM_DIR"
	# git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
# ) && \. "$NVM_DIR/nvm.sh"

# == brave ==
# sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
# sudo zypper addrepo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
# sudo zypper install brave-browser

# == vlc ==
sudo zypper install vlc

# == packman ==
# sudo zypper addrepo -cfp 90 http://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/ packman
# sudo zypper dist-upgrade --from packman --allow-vendor-change

# == flatpak ==
# sudo zypper install flatpak

# == spotify ==
# flatpak install com.spotify.Client

# == discord ==
# flatpak install com.discordapp.Discord

# == obs-studio ==
# flatpak install com.obsproject.Studio

exit

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
		fzf
		p7zip
		ranger
		neofetch
		dive

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

# awesome
git clone \
	git@github.com:deficient/battery-widget.git \
	$HOME/.config/awesome/battery-widget
