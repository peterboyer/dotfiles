#!/bin/bash

main() {
	link $HOME/_dotfiles/zsh/zshrc                      $HOME/.@
	link $HOME/_dotfiles/tmux/tmux.conf                 $HOME/.@
	link $HOME/_dotfiles/nvim                           $HOME/.config/@
	link $HOME/_dotfiles/kitty                          $HOME/.config/@

	link $HOME/_zone/ssh                                $HOME/.@
	link $HOME/_zone/_dotfiles.private/gphoto           $HOME/.@
	link $HOME/_zone/_dotfiles.private/obs/basic        $HOME/.config/obs-studio/@

	link $HOME/_dotfiles/_arch/xinitrc                  $HOME/.@
	link $HOME/_dotfiles/_arch/xresources               $HOME/.@
	link $HOME/_dotfiles/awesome                        $HOME/.config/@
	link $HOME/_zone/wallpapers/valley.jpg              $HOME/.config/wallpaper
	link $HOME/_zone/_dotfiles.private/autorandr        $HOME/.config/@

	link $HOME/_dotfiles/_arch/issue                    /etc/@ --sudo
	link $HOME/_dotfiles/_arch/vkeyboard.map            /usr/share/kbd/keymaps/@ --sudo
	link $HOME/_dotfiles/_arch/vconsole.conf            /etc/@ --sudo
	link $HOME/_dotfiles/_arch/fonts.conf               $HOME/.config/fontconfig/@
	link $HOME/_dotfiles/_arch/xkeyboard                /etc/default/keyboard
	link $HOME/_dotfiles/_arch/udev/60-keyboard.rules   /etc/udev/rules.d/@ --sudo

	link $HOME/_zone/fonts/CousineMono                  /usr/local/share/fonts/@ --sudo
	link $HOME/_zone/fonts/BerkeleyMono                 /usr/local/share/fonts/@ --sudo

	return

	link $HOME/_dotfiles/_arch/networkmanager/dns-servers.conf /etc/NetworkManager/conf.d/@ --sudo

	link $HOME/_dotfiles/_arch/bashrc $HOME/.@
	link $HOME/_dotfiles/_arch/bash_profile $HOME/.@
	link $HOME/_dotfiles/_arch/bash_logout $HOME/.@
	link $HOME/_dotfiles/_arch/zprofile $HOME/.@

	link $HOME/_dotfiles/_arch/xinitrc $HOME/.@
	link $HOME/_dotfiles/_arch/xmodmap $HOME/.Xmodmap
	link $HOME/_dotfiles/_arch/xinitrc.d/51-xrdb.sh /etc/X11/xinit/xinitrc.d/@ --sudo
	link $HOME/_dotfiles/_arch/xinitrc.d/52-xmodmap.sh /etc/X11/xinit/xinitrc.d/@ --sudo
	link $HOME/_dotfiles/_arch/xinitrc.d/71-udiskie.sh /etc/X11/xinit/xinitrc.d/@ --sudo
	link $HOME/_dotfiles/_arch/xinitrc.d/72-autorandr.sh /etc/X11/xinit/xinitrc.d/@ --sudo
	link $HOME/_dotfiles/_arch/xinitrc.d/81-xautolock.sh /etc/X11/xinit/xinitrc.d/@ --sudo

}

# link <src> <dest> [--sudo]
link() {
	src="$1"
	[[ ! -e "$src" ]] && echo "BADSRC: $src" && return
	[[ "$@" =~ "--sudo" ]] && sudocmd="sudo"
	src_name="$(basename $src)"
	dest="${2/"@"/${src_name}}"
	[[ -e $dest ]] && $sudocmd rm -r $dest
	dest_dir="$(dirname $dest)"
	dest_name="$(basename $dest)"
	$sudocmd mkdir -p $dest_dir
	cd $dest_dir
	$sudocmd ln -sf $src $dest_name
	cd $OLDPWD
	echo "LINKED: $src -> $dest"
}

main
