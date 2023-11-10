#!/bin/bash

UNAME="$(uname)"

main() {
	if [[ $UNAME == "Linux" ]]; then
	backup $HOME/_zone/_dotfiles.private/signal $HOME/.var/app/org.signal.Signal/config/Signal/.
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
