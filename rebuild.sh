#!/usr/bin/env bash

# usage: $0 <TARGET> [...]
# - TARGET: "home" or "work"

if [ "$1" == "home" ]; then
	sudo nixos-rebuild switch --flake ./nix#home --impure ${@:2}
elif [ "$1" == "work" ]; then
	nix run nix-darwin \
		--extra-experimental-features nix-command \
		--extra-experimental-features flakes \
		-- switch \
			--flake ./nix#work \
			${@:2}
else
	echo "Error: Missing target argument."
fi
