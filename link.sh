#!/usr/bin/env bash

# link <dest> <src> [<alias>] [<options>]
#   --sudo        execute as sudo
#   --absolute    src will not be prefixed with $HOME/_dotfiles/

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
  if [[ -d $DIR ]]; then
    mkdir -p $DIR
  fi
  TARGET="$DEST/$(basename ${ALIAS:-$SRC})"
  if [[ -e "$DIR$SRC" && ! -e "$TARGET" || ! -h "$TARGET" ]]; then
    cd $DEST;
    $SUDO ln -fs $DIR$SRC $ALIAS;
    cd $OLDPWD;
    echo "linked: $TARGET"
  fi
}

link $HOME zsh/zshrc .zshrc
link $HOME tmux/tmux.conf .tmux.conf
link $HOME/.config nvim
link $HOME/.config alacritty

link $HOME $HOME/_zone/_dotfiles.private/ssh .ssh --absolute
if [[ -d "$HOME/.ssh" ]]; then
  chmod 700 $HOME/.ssh
  chmod 600 $HOME/.ssh/id_rsa
  chmod 600 $HOME/.ssh/id_rsa.pub
fi

link $HOME $HOME/_zone/_dotfiles.private/gphoto .gphoto --absolute
link $HOME/.config/obs-studio $HOME/_zone/_dotfiles.private/obs/basic --absolute

if [[ "$UNAME" == "Linux" ]]; then
  link /etc/default _/grub --sudo;

  link /usr/local/bin _/xenv --sudo;
  if [[ ! -f "/user" ]]; then
    sudo echo "$USER" > /tmp/user
    sudo cp /tmp/user /
  fi

  link $HOME _/xmodmap .Xmodmap;
  link /etc/udev/rules.d _/udev/10-xmodmap.rules --sudo

  link $HOME _/xinitrc .xinitrc;
  link /etc/X11/xinit/xinitrc.d _/xinit/51-xrdb.sh --sudo
  link /etc/X11/xinit/xinitrc.d _/xinit/52-xmodmap.sh --sudo
  link /etc/X11/xinit/xinitrc.d _/xinit/70-autorandr.sh --sudo
  link /etc/X11/xinit/xinitrc.d _/xinit/80-xautolock.sh --sudo
  link $HOME _/zprofile .zprofile;

  link $HOME/.config _/awesome

  link $HOME/.config _/autorandr
  link /etc/udev/rules.d _/udev/10-autorandr.rules --sudo

  link /etc/systemd/system _/systemd/xmodmap@.service --sudo
  if [[ -z "$(systemctl status xmodmap@$USER | grep enabled)" ]]; then sudo systemctl enable xmodmap@$USER; fi

  link /etc/systemd/system _/systemd/slock@.service --sudo
  if [[ -z "$(systemctl status slock@$USER | grep enabled)" ]]; then sudo systemctl enable slock@$USER; fi

  link $HOME/.config/fontconfig _/fonts fonts.conf;
fi