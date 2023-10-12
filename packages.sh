#!/bin/bash

if [[ ! -h ~/.zshrc ]]; then
	echo "abort: run ./link.sh first!"
	exit 1
fi

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
# sudo zypper install eza
# sudo zypper install tmux
# sudo zypper install fzf
# sudo zypper install htop

# == general ==
# sudo zypper install git
# sudo zypper install neofetch
# sudo zypper install ranger
# sudo zypper install colorpicker
# sudo zypper install pdfarranger

# == docker ==
# sudo zypper install docker
# sudo zypper install docker-compose

# == kitty ==
# sudo zypper install kitty
# git clone git@github.com:dexpota/kitty-themes.git ~/.config/kitty-themes

# == lazygit ==
# export LAZYGIT_DIR="/usr/share/lazygit-bin" && (
	# sudo mkdir -p $LAZYGIT_DIR
	# sudo chown -R $USER:$USER $LAZYGIT_DIR
	# cd "$LAZYGIT_DIR"
	# curl -L https://github.com/jesseduffield/lazygit/releases/download/v0.39.1/lazygit_0.39.1_Linux_x86_64.tar.gz | tar -xz
	# sudo ln -s -t /usr/bin /usr/share/lazygit-bin/lazygit
# )

# == neovim ==
# sudo zypper install neovim
# sudo zypper install gcc # for treesitter
# sudo zypper install gcc-c++ # for treesitter
# sudo zypper install ripgrep # for telescope

# == node/npm/yarn ==
# export NVM_DIR="/usr/share/nvm-git" && (
	# sudo git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
	# sudo chown -R $USER:$USER $NVM_DIR
	# cd "$NVM_DIR"
	# git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
	# source $NVM_DIR/nvm.sh
	# nvm install --lts
	# npm install -g yarn
	# npm install -g pnpm
# ) && \. "$NVM_DIR/nvm.sh"

# == brave ==
# sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
# sudo zypper addrepo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
# sudo zypper install brave-browser

# == vlc ==
# sudo zypper install vlc

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
# sudo zypper install gphoto2-webcam
# flatpak install com.obsproject.Studio

# == fly ==
# curl -L https://fly.io/install.sh | sh

# == blender ==
# sudo zypper install blender

exit

PACKAGES=(
	lf
	docker
		docker-compose
		dive

sudo usermod -aG docker $USER
sudo systemctl enable docker --now

	ntfs-3g
	ifuse

	insomnia-bin

	gthumb

	peek
	flameshot

	calc
	cmatrix
	slides-bin
	joyutils
)
