#!/usr/bin/env bash

# https://gist.github.com/bbqtd/a4ac060d6f6b9ea6fe3aabe735aa9d95

curl -LO \
		https://invisible-island.net/datafiles/current/terminfo.src.gz \
		&& gunzip terminfo.src.gz

/usr/bin/tic -xe tmux-256color terminfo.src

infocmp -x tmux-256color

rm terminfo.src
