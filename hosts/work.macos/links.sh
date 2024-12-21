#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

. ~/_/dotfiles/links.sh

dotlink ~/.local/bin/host-links ~/_/dotfiles/hosts/work.macos/links.sh

dotlink ~/.zshrc      ~/_/dotfiles/zsh/zshrc.macos
dotlink ~/.gitconfig  ~/_/dotfiles.untracked/git/gitconfig
dotlink ~/.npmrc      ~/_/dotfiles.untracked/npm/npmrc
dotlink ~/.yarnrc     ~/_/dotfiles.untracked/yarn/yarnrc

dotlink ~/.config/ngrok/ngrok.yml ~/_/dotfiles.untracked/ngrok/ngrok.yml
