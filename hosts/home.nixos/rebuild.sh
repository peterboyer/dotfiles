#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

base=$(dirname $(readlink -f $0))
if [[ ! -h /etc/nixos ]]; then
	sudo rm -rf /etc/nixos
	sudo ln -sf $base /etc/nixos
fi

# [Flake not accessible through symlink](https://github.com/NixOS/nix/issues/8013)
sudo nixos-rebuild switch --flake "$(readlink -f /etc/nixos)#default" --show-trace
