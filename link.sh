#!/usr/bin/env bash

(cd ~ && ln -sf $HOME/_dotfiles/zsh/zshrc .zshrc)
(cd ~/.config && ln -sf $HOME/_dotfiles/nvim)
(cd ~/.config && ln -sf $HOME/_dotfiles/alacritty)
