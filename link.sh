#!/usr/bin/env bash

(cd ~ && ln -sf ./_dotfiles/zsh/zshrc .zshrc)
(cd ~ && ln -sf ./_dotfiles/tmux/tmux.conf .tmux.conf)
(cd ~/.config && ln -sf ./_dotfiles/nvim)
(cd ~/.config && ln -sf ./_dotfiles/alacritty)

if [[ -e ~/_zone/ssh ]]; then
  (cd ~ && ln -sf ./_zone/ssh .ssh)
fi
