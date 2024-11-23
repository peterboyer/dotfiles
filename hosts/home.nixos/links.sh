#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

dotlink ~/.local/bin/host-rebuild  ~/_/dotfiles/hosts/home.nixos/rebuild.sh
dotlink ~/.local/bin/host-links    ~/_/dotfiles/hosts/home.nixos/links.sh
dotlink ~/.local/bin/host-update   ~/_/dotfiles/hosts/home.nixos/update.sh

dotlink ~/.local/share/fonts/berkeley-mono ~/_/fonts/berkeley-mono

dotlink ~/.config/Signal  ~/_/dotfiles.untracked/signal

. ~/_/dotfiles/links.sh
