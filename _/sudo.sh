#!/usr/bin/env bash

# https://wiki.archlinux.org/title/GRUB#Configuration

(
  cd /etc/default;
  ln -fs /home/$oUSER/_dotfiles/_/grub;
  grub-mkconfig -o /boot/grub/grub.cfg
)
