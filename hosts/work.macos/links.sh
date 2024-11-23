#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

dotlink ~/.zshrc      ~/_/dotfiles/zsh/zshrc.macos
dotlink ~/.gitconfig  ~/_/dotfiles.untracked/git/gitconfig
dotlink ~/.npmrc      ~/_/dotfiles.untracked/npm/npmrc
dotlink ~/.yarnrc     ~/_/dotfiles.untracked/yarn/yarnrc

. ~/_/dotfiles/links.sh
