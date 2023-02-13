#!/bin/bash

main() {
	link ~/_zone/wallpapers/valley.jpg ~/.config/wallpaper

	link ./zsh/zshrc ~/.#
	link ./tmux/tmux.conf ~/.#
	link ./nvim ~/.config/#
	link ./_manjaro/sway ~/.config/#
	link ./_manjaro/flashfocus ~/.config/#

	link ~/_zone/ssh ~/.#
	if [[ -d "~/.ssh" ]]; then
		chmod 700 ~/.ssh
		chmod 600 ~/.ssh/id_rsa
		chmod 600 ~/.ssh/id_rsa.pub
	fi

	link ~/_zone/_dotfiles.private/gphoto ~/.#
	link ~/_zone/_dotfiles.private/obs/basic ~/.config/obs-studio/#
}

# link <src> <dest> [--sudo]
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
	cd $OLDPWD
	echo "LINKED: $src -> $dest"
}

export link

main
