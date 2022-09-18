#!/usr/bin/env bash

if [[ "$@" =~ "--help" ]]; then
  echo "usage: [<options>]"
  echo "  --grub        force grub-mkconfig"
  echo "  --install     install yay and packages"
  exit
fi

# link <dest> <src> [<alias>] [<options>]
#   --sudo              execute as sudo
#   --absolute          src will not be prefixed with $HOME/_dotfiles/

link() {
  DIR="$HOME/_dotfiles/"
  DEST="$1"
  SRC="$2"
  ALIAS="$3"
  if [[ "$@" =~ "--sudo" ]]; then
    SUDO="sudo"
  fi
  if [[ "$@" =~ "--absolute" ]]; then
    DIR=""
  fi
  if [[ "$ALIAS" =~ "--" ]]; then
    ALIAS=""
  fi
  TARGET="$DEST/$(basename ${ALIAS:-$SRC})"
  if [[ -e "$DIR$SRC" && ! -e "$TARGET" || ! -h "$TARGET" ]]; then
    cd $DEST;
    $SUDO ln -fs $DIR$SRC $ALIAS;
    cd $OLDPWD;
  fi
}

mkdir -p $HOME/_dev
mkdir -p $HOME/_zone

# https://wiki.archlinux.org/title/GRUB#Configuration
if [[ ! -h "/etc/default/grub" || "$@" =~ "--grub" ]]; then
  link /etc/default _/grub --sudo;
  sudo grub-mkconfig -o /boot/grub/grub.cfg
fi

mkdir -p $HOME/.config

link $HOME _/xinitrc .xinitrc;
link $HOME _/xinitrc.xmodmap .xinitrc.xmodmap;
link /etc/X11/xinit/xinitrc.d _/xinitrc.d/60-autorandr.sh --sudo
link $HOME _/xmodmap .Xmodmap;
link $HOME _/zprofile .zprofile;
link $HOME/.config _/awesome
link $HOME/.config _/autorandr
link /etc/udev/rules.d _/udev/10-local.rules --sudo
link /usr/local/bin _/system/resume.sh --sudo
link /etc/systemd/system _/system/resume.service --sudo
if [[ -z "$(systemctl status resume | grep enabled)" ]]; then sudo systemctl enable resume; fi
link $HOME/.config _/fontconfig;

link $HOME zsh/zshrc .zshrc
link $HOME tmux/tmux.conf .tmux.conf
link $HOME/.config nvim
link $HOME/.config alacritty

link $HOME $HOME/_zone/_dotfiles.private/ssh .ssh --absolute
link $HOME $HOME/_zone/_dotfiles.private/gphoto .gphoto --absolute

mkdir -p $HOME/.config/obs-studio
link $HOME/.config/obs-studio $HOME/_zone/_dotfiles.private/obs/basic --absolute

if [[ -d "$HOME/.ssh" ]]; then
  chmod 700 $HOME/.ssh
  chmod 600 $HOME/.ssh/id_rsa
  chmod 600 $HOME/.ssh/id_rsa.pub
fi

cd $HOME/_dotfiles
GIT_REMOTE="$(git remote -v | grep fetch | awk '{print $2}')"
if [[ "$GIT_REMOTE" =~ "https://" ]]; then
  git remote set-url origin $(echo $GIT_REMOTE | sed 's/https:\/\//git@/' | sed 's/\//:/')
fi
cd $OLDPWD

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
    alacritty
    ttf-jetbrains-mono
    nvm
    docker
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