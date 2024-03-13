#!/usr/bin/env bash

# usage: $0 <TARGET> [...]
# - TARGET: "home" or "work"

if [ "$1" == "home" ]; then
	sudo nixos-rebuild switch --flake ./nix/flake.nix#home --impure ${@:2}
elif [ "$1" == "work" ]; then
	darwin-rebuild switch --flake ./nix/flake.nix#work ${@:2}
else
	echo "Error: Missing target argument."
fi
