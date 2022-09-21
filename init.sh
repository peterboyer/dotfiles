#!/usr/bin/env bash

if [[ "$@" =~ "--help" ]]; then
  echo "usage: [<options>]"
  echo "  --grub        force grub-mkconfig"
  echo "  --install     install yay and packages"
  exit
fi

if [[ "$UNAME" != "Linux" && ! "$@" =~ "--ignore-uname" ]]; then
  echo "fatal: incompatible \$UNAME, expected 'Linux', got '$UNAME'"
  echo "       run with --ignore-uname to bypass this warning (use with caution)"
  exit 1
fi

mkdir -p $HOME/_dev
mkdir -p $HOME/_zone

cd $HOME/_dotfiles
GIT_REMOTE="$(git remote -v | grep fetch | awk '{print $2}')"
if [[ "$GIT_REMOTE" =~ "https://" ]]; then
  git remote set-url origin $(echo $GIT_REMOTE | sed 's/https:\/\//git@/' | sed 's/\//:/')
fi
cd $OLDPWD

$(dirname $0)/link.sh

# https://wiki.archlinux.org/title/GRUB#Configuration
if [[ ! -h "/etc/default/grub" || "$@" =~ "--grub" ]]; then
  sudo grub-mkconfig -o /boot/grub/grub.cfg
fi

if [[ "$@" =~ "--install" ]]; then
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
fi

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
