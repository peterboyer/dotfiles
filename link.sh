#!/bin/bash

[[ "$@" =~ "--force" ]] && force=true

# link <src> <dest> [--sudo|--force]
link() {
	src="$1"
	if [[ ! "$src" =~ ^/ ]]; then
		relative_dir="$(dirname ${BASH_SOURCE[1]:-BASH_SOURCE[0]})"
		src="$(realpath $relative_dir/$src)"
	fi
	if [[ ! -e "$src" ]]; then
		echo "BADSRC: $src"
		return
	fi
	src_name="$(basename $src)"
	dest="${2/"#"/${src_name}}"
	if [[ ! "$force" == "true" && -e $dest ]]; then
		echo "EXISTS: $dest"
		return
	fi
	dest_dir="$(dirname $dest)"
	dest_name="$(basename $dest)"
	if [[ "$@" =~ "--sudo" ]]; then
		sudocmd="sudo"
	fi
	$sudocmd mkdir -p $dest_dir
	cd $dest_dir
	$sudocmd ln -sf $src $dest_name
	cd $OLDPWD
	echo "LINKED: $src -> $dest"
}

export link

link ./zsh/zshrc ~/.#
link ./tmux/tmux.conf ~/.#
link ./nvim ~/.config/#
link ./alacritty ~/.config/#
link ./kitty ~/.config/#

link ~/_zone/_dotfiles.private/ssh ~/.#
if [[ -d "~/.ssh" ]]; then
	chmod 700 ~/.ssh
	chmod 600 ~/.ssh/id_rsa
	chmod 600 ~/.ssh/id_rsa.pub
fi

link ~/_zone/_dotfiles.private/gphoto ~/.#
link ~/_zone/_dotfiles.private/obs/basic ~/.config/obs-studio/#

os="_"
if [[ "$(uname)" == "Linux" ]]; then os=arch; fi
if [[ "$(uname)" == "Darwin" ]]; then os=macos; fi

if [[ "$os" == "arch" ]]; then
	link ./_arch/awesome ~/.config/#
	link ~/_zone/wallpapers/looker.jpg ~/.config/wallpaper

	link ./fonts /usr/local/share/# --sudo
	link ./_arch/fonts.conf ~/.config/fontconfig/#

	link ./_arch/networkmanager/dns-servers.conf /etc/NetworkManager/conf.d/# --sudo

	link ./_arch/env ~/.#
	link ./_arch/bashrc ~/.#
	link ./_arch/bash_profile ~/.#
	link ./_arch/bash_logout ~/.#
	link ./_arch/zprofile ~/.#
	link ./_arch/issue /etc/# --sudo

	link ./_arch/xinitrc ~/.#;
	link ./_arch/xmodmap ~/.Xmodmap
	link ./_arch/xresources ~/.Xresources
	link ./_arch/xinitrc.d/51-xrdb.sh /etc/X11/xinit/xinitrc.d/# --sudo
	link ./_arch/xinitrc.d/52-xmodmap.sh /etc/X11/xinit/xinitrc.d/# --sudo
	link ./_arch/xinitrc.d/71-udiskie.sh /etc/X11/xinit/xinitrc.d/# --sudo
	link ./_arch/xinitrc.d/72-autorandr.sh /etc/X11/xinit/xinitrc.d/# --sudo
	link ./_arch/xinitrc.d/81-xautolock.sh /etc/X11/xinit/xinitrc.d/# --sudo

	# TODO: remove
	link ./_arch/bin/_user /usr/local/bin/# --sudo
	if [[ ! -e "/user" ]]; then
		sudo echo "$USER" > /user
	fi

	link ./_arch/udev/10-xmodmap.rules /etc/udev/rules.d/# --sudo
	link ./_arch/udev/10-autorandr.rules /etc/udev/rules.d/# --sudo
	link ~/_zone/_dotfiles.private/autorandr ~/.config/#

	link ./_arch/systemd/slock@.service /etc/systemd/system/# --sudo
	link ./_arch/systemd/xmodmap@.service /etc/systemd/system/# --sudo

	systemd_enable_service_for_user() {
		if [[ -z "$(systemctl status $1@$USER | grep enabled)" ]]; then
			sudo systemctl enable $1@$USER
		fi
	}
	systemd_enable_service_for_user slock
	systemd_enable_service_for_user xmodmap
fi
