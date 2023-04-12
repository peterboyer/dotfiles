#!/bin/bash

main() {
	link $HOME/_dotfiles/zsh/zshrc                      $HOME/.@
	link $HOME/_dotfiles/tmux/tmux.conf                 $HOME/.@
	link $HOME/_dotfiles/nvim                           $HOME/.config/@
	link $HOME/_dotfiles/kitty                          $HOME/.config/@

	link $HOME/_zone/ssh                                $HOME/.@
	link $HOME/_zone/_dotfiles.private/gphoto           $HOME/.@
	link $HOME/_zone/_dotfiles.private/obs/basic        $HOME/.config/obs-studio/@
	link $HOME/_zone/fonts/BerkeleyMono                 $HOME/.config/fonts/@
	link $HOME/_dotfiles/fonts.conf                     $HOME/.config/fontconfig/@
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
