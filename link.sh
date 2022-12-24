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
  TARGET="$DEST/$(basename ${ALIAS:-$SRC})"
  if [[ -d "$(dirname $DIR$SRC)" && -e "$DIR$SRC" && (! -e "$TARGET" || ! -h "$TARGET") ]]; then
    if [[ ! -d $DEST ]]; then
      $SUDO mkdir -p $DEST
    fi
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
  link $HOME/.config _/awesome
  link $HOME/.config/fontconfig _/fonts fonts.conf;

  link /etc/default _/grub --sudo;

  link /usr/local/bin _/bin/_suspend --sudo;
  link /usr/local/bin _/bin/_reboot --sudo;
  link /usr/local/bin _/bin/_shutdown --sudo;
  link /usr/local/bin _/bin/_user --sudo;
  if [[ ! -f "/user" ]]; then
    sudo echo "$USER" > /tmp/user
    sudo cp /tmp/user /
  fi

  link $HOME _/xinitrc .xinitrc;
  link /etc/X11/xinit/xinitrc.d _/xinit/51-xrdb.sh --sudo
  link /etc/X11/xinit/xinitrc.d _/xinit/52-xmodmap.sh --sudo
  link /etc/X11/xinit/xinitrc.d _/xinit/71-udiskie.sh --sudo
  link /etc/X11/xinit/xinitrc.d _/xinit/72-autorandr.sh --sudo
  link /etc/X11/xinit/xinitrc.d _/xinit/81-xautolock.sh --sudo
  link $HOME _/zprofile .zprofile;

  link $HOME _/xmodmap .Xmodmap;
  link $HOME _/xresources .Xresources;
  link /etc/udev/rules.d _/udev/10-xmodmap.rules --sudo

  link $HOME/.config $HOME/_zone/_dotfiles.private/autorandr --absolute
  link /etc/udev/rules.d _/udev/10-autorandr.rules --sudo

  link /etc/systemd/system _/systemd/xmodmap@.service --sudo
  if [[ -z "$(systemctl status xmodmap@$USER | grep enabled)" ]]; then sudo systemctl enable xmodmap@$USER; fi

  link /etc/systemd/system _/systemd/slock@.service --sudo
  if [[ -z "$(systemctl status slock@$USER | grep enabled)" ]]; then sudo systemctl enable slock@$USER; fi

  link /etc/pulse/system.pa.d _/pulse/user.pa --sudo

  link /usr/local/share fonts --sudo
fi
