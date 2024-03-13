#!/bin/bash

UNAME="$(uname)"

main() {
	link ~/_dotfiles/zsh/zshrc                      ~/.@
	link ~/_dotfiles/tmux/tmux.conf                 ~/.@
	link ~/_dotfiles/nvim                           ~/.config/@
	link ~/_dotfiles/lazygit                        ~/.config/@

	if [[ $UNAME == "Linux" ]]; then
	link ~/_dotfiles/kitty                          ~/.config/@
	link ~/_dotfiles/fonts.conf                     ~/.config/fontconfig/@
	fi

	if [[ $UNAME == "Linux" ]]; then
	link ~/_zone/fonts/active                       ~/.local/share/fonts
	link ~/_zone/_dotfiles.untracked/ssh            ~/.@
	link ~/_zone/_dotfiles.untracked/gphoto         ~/.@
	link ~/_zone/_dotfiles.untracked/obs/basic      ~/.var/obs-studio/@
	fi
}

# link <src> <dest> [--sudo]
link() {
	src="$1"
	[[ ! -e "$src" ]] && echo "BADSRC: $src" && return
	[[ "$@" =~ "--sudo" ]] && sudocmd="sudo"
	src_name="$(basename $src)"
	dest="${2/"@"/${src_name}}"
	[[ -e $dest ]] && $sudocmd rm -r $dest
	[[ -e $dest ]] && echo "ERROR: failed to remove $dest" && exit 1
	dest_dir="$(dirname $dest)"
	dest_name="$(basename $dest)"
	$sudocmd mkdir -p $dest_dir
	cd $dest_dir
	$sudocmd ln -sf $src $dest_name
	cd $OLDPWD
	echo "LINKED: $src -> $dest"
}

main
