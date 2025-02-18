#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

dotlink ~/.local/bin/host-update    ~/_/dotfiles/hosts/home.fedora/update.sh
dotlink ~/.local/bin/host-links     ~/_/dotfiles/hosts/home.fedora/links.sh
dotlink ~/.local/bin/host-packages  ~/_/dotfiles/hosts/home.fedora/packages.sh

dotlink ~/.local/share/fonts/berkeley-mono ~/_/fonts/berkeley-mono
dotlink ~/.local/share/fonts/apple-fonts ~/_/fonts/apple-fonts

dotlink ~/.var/app/org.signal.Signal/config/Signal ~/_/dotfiles.untracked/signal

dotlink /etc/samba/smb.conf ~/_/dotfiles/samba/smb.conf --sudo --copy
# sudo systemctl restart smb.service

. ~/_/dotfiles/links.sh
