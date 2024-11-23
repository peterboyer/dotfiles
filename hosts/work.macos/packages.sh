#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

base=$(dirname $(readlink -f $0))

if ! (command -v brew >/dev/null 2>&1); then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [[ ! -d ~/.oh-my-zsh ]]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

brew bundle install --file=$base/brewfile
