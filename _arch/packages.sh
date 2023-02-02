#!/usr/bin/env bash

# usage: [source] ./packages.sh [<function>]
# <function>:
#   bootstrap: install/configure everything (fresh system)
#   update: only update
#   install: update then install all stable packages
#   install_aur: same as install + aur packages
#   etc...

PACKAGES=(
	htop
	tmux
	p7zip
	openssh
	zsh
	AUR:oh-my-zsh-git
	exa
	neofetch
	xclip
	AUR:lf-bin
	ripgrep
	neovim
	lazygit
	xorg
	xorg-xinit
	xorg-xrandr
	autorandr
	brightnessctl
	bluez
	bluez-utils
	awesome
	acpid
	slock
	xautolock
	kitty
	ttf-jetbrains-mono
	AUR:nvm
	docker
	docker-compose
	calc
	peek
	xcolor
	flameshot
	gimp
	pdfarranger
	AUR:brave-bin
	signal-desktop
	AUR:flyctl-bin
	AUR:spotify
	udisks2
	udiskie
	ntfs-3g
	ifuse
	nemo
	gthumb
	vlc
	v4l2loopback-dkms
	gphoto2
	obs-studio
	AUR:obs-linuxbrowser-bin
	joyutils
	cmatrix
	AUR:slides-bin
	pipewire
	pipewire-alsa
	pipewire-pulse
	wireplumber
)

BOOTSTRAP=()

yay_install() {
	# https://github.com/Jguer/yay
	if [[ "$(which yay &> /dev/null; echo $?)" != "0" ]]; then
		git clone https://aur.archlinux.org/yay-bin.git $HOME/yay
		(cd $HOME/yay && yes | makepkg -si --noconfirm)
		rm -rf $HOME/yay
	fi
}
BOOTSTRAP+=("yay_install")

update() {
	yay -Sy --noconfirm archlinux-keyring
	yay -Syu --noconfirm
}

install_stable() {
	packages=$((IFS=$'\n' && echo "${PACKAGES[*]}") | grep -v '^AUR:')
	yay -S --needed --noconfirm ${packages[@]}
}

install_aur() {
	packages=$((IFS=$'\n' && echo "${PACKAGES[*]}") | grep '^AUR:' | sed 's/AUR://')
	yay -S --needed --noconfirm ${packages[@]}
}

install() {
	update
	install_stable
}
install_quick() {
	# no update
	install_stable
}

install_all() {
	install
	install_aur
}
BOOTSTRAP+=("install_all")

# zsh

zsh_chsh() {
	if [[ "$(which zsh &> /dev/null; echo $?)" == "0" ]]; then
		if [[ ! "$SHELL" =~ "zsh" ]]; then chsh -s $(which zsh); fi
	fi
}

zsh_init() {
	zsh_chsh
}
BOOTSTRAP+=("zsh_init")

# nvm/node/npm

nvm_install_lts() {
	if [[ "$(which node &> /dev/null; echo $?)" != "0" ]]; then
		source /usr/share/nvm/init-nvm.sh
		nvm install --lts
	fi
}

# docker

docker_usergroup() {
	if [[ -z "$(cat /etc/group | grep docker)" ]]; then
		sudo groupadd docker;
	fi
	if [[ -z "$(groups $USER | grep docker)" ]]; then
		sudo usermod -aG docker $USER;
	fi
}

docker_enable() {
	if [[ -z "$(systemctl status docker | grep running)" ]]; then
		sudo systemctl enable docker --now;
	fi
}

docker_init() {
	docker_usergroup
	docker_enable
}
BOOTSTRAP+=("docker_init")

# bluez (bluetooth service)

bluetooth_enable() {
	if [[ -z "$(systemctl status bluetooth | grep running)" ]]; then
		sudo systemctl enable bluetooth --now;
	fi
}

bluetooth_init() {
	bluetooth_enable
}
BOOTSTRAP+=("bluetooth_init")

# acpid (power/battery information service)

acpid_enable() {
	if [[ -z "$(systemctl status acpid | grep running)" ]]; then
		sudo systemctl enable acpid --now;
	fi
}

acpid_init() {
	acpid_enable
}
BOOTSTRAP+=("acpid_init")

# awesome
awesome_deps() {
	if [[ ! -d ~/.config/awesome/battery-widget ]]; then
		git clone https://github.com/deficient/battery-widget.git ~/.config/awesome/battery-widget
	fi
}

awesome_init() {
	awesome_deps
}
BOOTSTRAP+=("awesome_init")

bootstrap() {
	for item in "${BOOTSTRAP[@]}"; do
		$item
	done
}

if [[ -n "$1" ]]; then
	if [[ `type -t $1` = "function" ]]; then
		echo exec: function "$1"
		$1
	else
		echo fatal: function "$1" is not recognised
	fi
fi
