#!/usr/bin/env bash

(cd ~ && ln -sf $HOME/_dotfiles/zsh/zshrc .zshrc)
(cd ~ && ln -sf $HOME/_dotfiles/tmux/tmux.conf .tmux.conf)
(cd ~/.config && ln -sf $HOME/_dotfiles/nvim)
(cd ~/.config && ln -sf $HOME/_dotfiles/alacritty)

if [[ -e ~/_zone/ssh ]]; then
  (cd ~ && ln -sf $HOME/_zone/ssh .ssh)
fi
