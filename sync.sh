#!/usr/bin/env bash

# usage: $0 <TARGET> [...]
# - TARGET: "home" or "work"

set -eo pipefail

TARGET="$1"
if [ "$TARGET" == "home" ]; then
	sudo nixos-rebuild switch --flake ./os#home --impure
	dotbot -c ./dotbot.yaml
	dotbot -c ./dotbot.home.yaml
elif [ "$TARGET" == "work" ]; then
	# autoinstall homebrew
	set +e; $(brew --version &>/dev/null); has_brew=$?; set -e;
	if [[ $has_brew != 0 ]]; then
		echo installing homebrew ...
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi
	# autoinstall oh-my-zsh
	if [[ ! -d ~/.oh-my-zsh ]]; then
		echo installing oh-my-zsh ...
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	fi
	brew bundle install --file=./os/user.packages.brewfile
	dotbot -c ./dotbot.yaml
	dotbot -c ./dotbot.work.yaml
fi
