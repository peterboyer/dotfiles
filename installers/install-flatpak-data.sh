#!/bin/bash

UNAME="$(uname)"

main() {
	if [[ $UNAME == "Linux" ]]; then
	backup ~/_zone/_dotfiles.private/signal ~/.var/app/org.signal.Signal/config/Signal/.
	backup ~/_zone/_dotfiles.private/obs ~/.var/app/com.obsproject.Studio/config/obs-studio/basic/.
	fi
}

# link <src> <dest> [--sudo]
backup() {
	dest="$1"
	src="$2"
	[[ ! -e $src ]] && echo "BADSRC: $src" && return
	echo rm -R $dest
	echo mkdir -p $dest
	echo cp -R $src $dest
}

main
