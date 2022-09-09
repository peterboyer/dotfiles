#!/usr/bin/env bash

# https://github.com/Jguer/yay

if [[ "$(which yay &> /dev/null; echo $?)" != "0" ]]; then
  (
    cd $HOME;
    git clone https://aur.archlinux.org/yay-bin.git;
    cd yay-bin;
    yes | makepkg -si --noconfirm;
    rm -rf $HOME/yay-bin;
  )
fi

# packages

PACKAGES=(
  htop
  neovim
  pulseaudio
  pulsemixer
  xorg
  xorg-xinit
  xwallpaper
  alacritty
  ttf-jetbrains-mono
  bspwm
  sxhkd
  dmenu
  polybar
)

yay -Syu
yay --noconfirm -S ${PACKAGES[@]}

# ensure .config dir

mkdir -p ~/.config

# https://wiki.archlinux.org/title/Font_configuration#Fontconfig_configuration

(
  cd ~/.config;
  ln -fs ../_dotfiles/_/fontconfig;
)

# https://wiki.archlinux.org/title/Bspwm#Configuration

(
  cd ~/.config;
  ln -fs ../_dotfiles/bspwm;
  ln -fs ../_dotfiles/sxhkd;
)

# https://wiki.archlinux.org/title/Polybar#Running_with_a_window_manager

(
  cd ~/.config;
  ln -fs ../_dotfiles/polybar;
)

# https://wiki.archlinux.org/title/Xinit#Configuration

(
  cd ~;
  ln -fs ./_dotfiles/xinit .xinitrc;
)

# https://wiki.archlinux.org/title/Xinit#Autostart_X_at_login

(
  cd ~;
  ln -fs ./_dotfiles/bash_profile .bash_profile;
)
