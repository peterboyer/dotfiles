#!/bin/bash

UNAME="$(uname)"

main() {
	link $HOME/_dotfiles/zsh/zshrc                      $HOME/.@
	link $HOME/_dotfiles/tmux/tmux.conf                 $HOME/.@
	link $HOME/_dotfiles/nvim                           $HOME/.config/@
	link $HOME/_dotfiles/lazygit                        $HOME/.config/@

	if [[ $UNAME == "Linux" ]]; then
	link $HOME/_dotfiles/kitty                          $HOME/.config/@
	link $HOME/_dotfiles/fonts.conf                     $HOME/.config/fontconfig/@
	fi

	if [[ $UNAME == "Linux" ]]; then
	link $HOME/_zone/fonts/active                       $HOME/.local/share/fonts
	link $HOME/_zone/_dotfiles.untracked/ssh            $HOME/.@
	link $HOME/_zone/_dotfiles.untracked/gphoto         $HOME/.@
	link $HOME/_zone/_dotfiles.untracked/obs/basic      $HOME/.var/obs-studio/@
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
