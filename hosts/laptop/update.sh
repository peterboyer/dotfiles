#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

sudo dnf upgrade
flatpak update

sudo dnf install -y zsh git btrfs-assistant

if ! (sudo snapper get-config >/dev/null 2>&1); then
    sudo snapper create-config / \
    && sudo snapper set-config TIMELINE_CREATE=no \
    && sudo snapper get-config \
    && sudo snapper create
fi

if [[ ! -d ~/.oh-my-zsh ]]; then
    RUNZSH='no' \
    KEEP_ZSHRC='yes' \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
