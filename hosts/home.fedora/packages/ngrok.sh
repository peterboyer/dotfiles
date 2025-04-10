#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

if ! (command -v ngrok >/dev/null 2>&1); then
	tmp=$(mktemp)
	trap "rm $tmp" EXIT
	wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz -O $tmp
	sudo tar xvzf $tmp -C /usr/local/bin
fi
