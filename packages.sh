#!/usr/bin/env bash

# https://github.com/Jguer/yay
if [[ "$(which yay &> /dev/null; echo $?)" != "0" ]]; then
  git clone https://aur.archlinux.org/yay-bin.git $HOME/yay
  (cd $HOME/yay && yes | makepkg -si --noconfirm)
  rm -rf $HOME/yay
fi

PACKAGES=(
  htop
  tmux
  unzip
  rsync
  openssh
  zsh
  oh-my-zsh-git # aur
  exa
  xclip
  lf-bin # aur
  neovim
  lazygit
  xorg
  xorg-xinit
  xorg-xrandr
  autorandr
  pulseaudio
  pulsemixer
  awesome
  slock
  xautolock
  alacritty
  ttf-jetbrains-mono
  nvm
  docker
  flameshot
  brave-bin # aur
)

yay -Syu
yay -S --needed --noconfirm ${PACKAGES[@]}

# zsh
if [[ "$(which zsh &> /dev/null; echo $?)" == "0" ]]; then
  if [[ ! "$SHELL" =~ "zsh" ]]; then chsh -s $(which zsh); fi
fi

# docker
if [[ "$(which docker &> /dev/null; echo $?)" == "0" ]]; then
  if [[ -z "$(systemctl status docker | grep running)" ]]; then sudo systemctl enable docker --now; fi
  if [[ -z "$(cat /etc/group | grep docker)" ]]; then sudo groupadd docker; fi
  if [[ -z "$(groups $USER | grep docker)" ]]; then sudo usermod -aG docker $USER; fi
fi
