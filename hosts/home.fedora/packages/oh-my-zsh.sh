#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

if [[ ! -d ~/.oh-my-zsh ]]; then
	RUNZSH='no' \
	KEEP_ZSHRC='yes' \
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
