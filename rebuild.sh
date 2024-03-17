#!/usr/bin/env bash

# usage: $0 <TARGET> [...]
# - TARGET: "home" or "work"

if [ "$1" == "home" ]; then
	sudo nixos-rebuild switch --flake ./os#home --impure ${@:2}
	# dotbot
elif [ "$1" == "work" ]; then
	brew bundle install --file=./os/user.packages.brewfile
	# dotbot
else
	echo "Error: Missing target argument."
fi
