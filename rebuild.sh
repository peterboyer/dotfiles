#!/usr/bin/env bash

# usage: $0 <TARGET> [...]
# - TARGET: "home" or "work"

set -euo pipefail

TARGET="${1:?Missing target argument.}"

if [ "$TARGET" == "home" ]; then
	sudo nixos-rebuild switch --flake ./os#home --impure
	dotbot -c ./dotbot.yaml
elif [ "$TARGET" == "work" ]; then
	brew bundle install --file=./os/user.packages.brewfile
	dotbot -c ./dotbot.yaml
else
	echo "Error: Invalid target."
fi
