#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

dotlink ~/.ssh             ~/_/dotfiles.untracked/ssh
dotlink ~/.zshrc           ~/_/dotfiles/zsh/zshrc
dotlink ~/.gitconfig       ~/_/dotfiles/git/gitconfig
dotlink ~/.tmux.conf       ~/_/dotfiles/tmux/tmux.conf
dotlink ~/.config/nvim     ~/_/dotfiles/nvim
dotlink ~/.config/lazygit  ~/_/dotfiles/lazygit
dotlink ~/.config/kitty    ~/_/dotfiles/kitty
