#!/usr/bin/env bash

# usage: $0 <TARGET> [...]
# - TARGET: "home" or "work"

set -eo pipefail

TARGET="$1"
if [ "$TARGET" == "home" ]; then
	sudo nixos-rebuild switch --flake ./os#home --impure
elif [ "$TARGET" == "work" ]; then
	brew bundle install --file=./os/user.packages.brewfile
fi

export DOTBOT_ENV="$TARGET"
dotbot -c ./dotbot.yaml
