#!/bin/bash

main() {
	link ~/_dotfiles/zsh/zshrc ~/.@
	link ~/_dotfiles/tmux/tmux.conf ~/.@
	link ~/_dotfiles/nvim ~/.config/@

	link ~/_zone/_dotfiles.private/ssh ~/.@
	if [[ -d "~/.ssh" ]]; then
		chmod 700 ~/.ssh
		chmod 600 ~/.ssh/id_rsa
		chmod 600 ~/.ssh/id_rsa.pub
	fi

	link ~/_zone/wallpapers/valley.jpg ~/.config/wallpaper
	link ~/_zone/_dotfiles.private/gphoto ~/.@
	link ~/_zone/_dotfiles.private/obs/basic ~/.config/obs-studio/@

	link ~/_dotfiles/_arch/issue /etc/@ --sudo
	link ~/_dotfiles/_arch/personal.map /usr/share/kbd/keymaps/@ --sudo
	link ~/_dotfiles/_arch/vconsole.conf /etc/@ --sudo

	return

	link ~/_dotfiles/fonts /usr/local/share/@ --sudo
	link ~/_dotfiles/_arch/fonts.conf ~/.config/fontconfig/@

	link ~/_dotfiles/_arch/networkmanager/dns-servers.conf /etc/NetworkManager/conf.d/@ --sudo

	link ~/_dotfiles/_arch/env ~/.@
	link ~/_dotfiles/_arch/bashrc ~/.@
	link ~/_dotfiles/_arch/bash_profile ~/.@
	link ~/_dotfiles/_arch/bash_logout ~/.@
	link ~/_dotfiles/_arch/zprofile ~/.@

	link ~/_dotfiles/_arch/xinitrc ~/.@
	link ~/_dotfiles/_arch/xmodmap ~/.Xmodmap
	link ~/_dotfiles/_arch/xresources ~/.Xresources
	link ~/_dotfiles/_arch/xinitrc.d/51-xrdb.sh /etc/X11/xinit/xinitrc.d/@ --sudo
	link ~/_dotfiles/_arch/xinitrc.d/52-xmodmap.sh /etc/X11/xinit/xinitrc.d/@ --sudo
	link ~/_dotfiles/_arch/xinitrc.d/71-udiskie.sh /etc/X11/xinit/xinitrc.d/@ --sudo
	link ~/_dotfiles/_arch/xinitrc.d/72-autorandr.sh /etc/X11/xinit/xinitrc.d/@ --sudo
	link ~/_dotfiles/_arch/xinitrc.d/81-xautolock.sh /etc/X11/xinit/xinitrc.d/@ --sudo

	link ~/_dotfiles/_arch/udev/10-xmodmap.rules /etc/udev/rules.d/@ --sudo
	link ~/_zone/_dotfiles.private/autorandr ~/.config/@
}

# link <src> <dest> [--sudo]
link() {
	src="$1"
	if [[ ! -e "$src" ]]; then
		echo "BADSRC: $src"
		return
	fi
	src_name="$(basename $src)"
	dest="${2/"@"/${src_name}}"
	# delete, if exists and not symlink and is directory
	if [[ -e $dest && ! -h $dest && -d $dest ]]; then
		rm -r $dest
	fi
	dest_dir="$(dirname $dest)"
	dest_name="$(basename $dest)"
	if [[ "$@" =~ "--sudo" ]]; then
		sudocmd="sudo"
	fi
	$sudocmd mkdir -p $dest_dir
	cd $dest_dir
	$sudocmd ln -sf $src $dest_name
	cd -
	echo "LINKED: $src -> $dest"
}

main
