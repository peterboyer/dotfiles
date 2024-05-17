#!/usr/bin/env bash

# usage: $0 <TARGET> [...]
#
# - <TARGET>: "home" or "work"
# - --no-install, skips installing packages
# - --no-link, skips linking dotfiles

set -eo pipefail

TARGET="${1:?fatal: no TARGET}"
if [[ "$TARGET" == "home" ]]; then
	if [[ ! "${@}" =~ "--no-install" ]]; then
		sudo nixos-rebuild switch --flake ./os#home --impure
	else
		echo skip: install ...
	fi
	if [[ ! "${@}" =~ "--no-link" ]]; then
		dotbot -c ./dotbot.yaml
		dotbot -c ./dotbot.home.yaml
	else
		echo skip: link ...
	fi
elif [[ "$TARGET" == "work" ]]; then
	if [[ ! "${@}" =~ "--no-install" ]]; then
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
	else
		echo skip: install ...
	fi
	if [[ ! "${@}" =~ "--no-link" ]]; then
		dotbot -c ./dotbot.yaml
		dotbot -c ./dotbot.work.yaml
	else
		echo skip: link ...
	fi
else
	echo fatal: invalid TARGET: $TARGET
	exit 1
fi
