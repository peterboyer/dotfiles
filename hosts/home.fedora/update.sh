#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

if (command -v snapper >/dev/null 2>&1); then
	echo snapshot ...
	sudo snapper create
fi

echo dnf ...
sudo dnf upgrade

echo flatpak ...
flatpak update
