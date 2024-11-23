#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

dotlink ~/.local/bin/host-update    ~/_/dotfiles/hosts/home.fedora/update.sh
dotlink ~/.local/bin/host-links     ~/_/dotfiles/hosts/home.fedora/links.sh
dotlink ~/.local/bin/host-packages  ~/_/dotfiles/hosts/home.fedora/packages.sh

dotlink ~/.local/share/fonts/berkeley-mono ~/_/fonts/berkeley-mono

dotlink ~/.config/Signal  ~/_/dotfiles.untracked/signal

. ~/_/dotfiles/links.sh
