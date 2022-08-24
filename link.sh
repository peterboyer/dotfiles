#!/usr/bin/env bash

(cd ~/.config && ln -sf $HOME/_dotfiles/nvim)
(cd ~ && ln -sf $HOME/_dotfiles/zsh/zshrc .zshrc)
