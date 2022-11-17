#!/usr/bin/env bash

# usage [<options>]:
# --aur     also install aur packages

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
  bind
  openssh
  zsh
  AUR:oh-my-zsh-git
  exa
  xclip
  AUR:lf-bin
  ripgrep
  neovim
  lazygit
  xorg
  xorg-xinit
  xorg-xrandr
  autorandr
  bluez
  bluez-utils
  pulseaudio
  pulseaudio-bluetooth
  pulsemixer
  awesome
  acpid
  slock
  xautolock
  alacritty
  ttf-jetbrains-mono
  AUR:nvm
  docker
  docker-compose
  calc
  peek
  flameshot
  gimp
  pdfarranger
  AUR:brave-bin
  signal-desktop
  AUR:flyctl-bin
  AUR:spotify
  udisks2
  udiskie
  ntfs-3g
  ifuse
  nemo
  gthumb
  vlc
  linux-headers
  v4l2loopback-dkms
  gphoto2
  obs-studio
  AUR:obs-linuxbrowser-bin
  joyutils
)

packages=$((IFS=$'\n' && echo "${PACKAGES[*]}") | grep -v '^AUR:')
packagesaur=$((IFS=$'\n' && echo "${PACKAGES[*]}") | grep '^AUR:' | sed 's/AUR://')

yay -Syu
yay -S --needed --noconfirm ${packages[@]}
if [[ "$@" =~ "--aur" ]]; then
  yay -S --needed --noconfirm ${packagesaur[@]}
fi

# zsh
if [[ "$(which zsh &> /dev/null; echo $?)" == "0" ]]; then
  if [[ ! "$SHELL" =~ "zsh" ]]; then chsh -s $(which zsh); fi
fi

# docker
if [[ -z "$(systemctl status docker | grep running)" ]]; then
  sudo systemctl enable docker --now;
fi
if [[ -z "$(cat /etc/group | grep docker)" ]]; then
  sudo groupadd docker;
fi
if [[ -z "$(groups $USER | grep docker)" ]]; then
  sudo usermod -aG docker $USER;
fi

# bluez
if [[ -z "$(systemctl status bluetooth | grep running)" ]]; then
  sudo systemctl enable bluetooth --now;
fi

# acpid
if [[ -z "$(systemctl status acpid | grep running)" ]]; then
  sudo systemctl enable acpid --now;
fi

# awesome
if [[ ! -d ~/.config/awesome/battery-widget ]]; then
  git clone https://github.com/deficient/battery-widget.git ~/.config/awesome/battery-widget
fi
