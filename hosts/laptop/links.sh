#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

base=$(dirname $0)

function main() {
	link ~/.ssh                 ~/_/dotfiles.untracked/ssh
	link ~/.zshrc               ~/_/dotfiles/zsh/zshrc
	link ~/.gitconfig           ~/_/dotfiles/git/gitconfig

	link ~/.tmux.conf           ~/_/dotfiles/tmux/tmux.conf
	link ~/.config/nvim         ~/_/dotfiles/nvim
	link ~/.config/lazygit      ~/_/dotfiles/lazygit
	link ~/.config/kitty        ~/_/dotfiles/kitty

	link ~/.local/bin/host-update    ~/_/dotfiles/hosts/laptop/update.sh
	link ~/.local/bin/host-links     ~/_/dotfiles/hosts/laptop/links.sh
	link ~/.local/bin/host-packages  ~/_/dotfiles/hosts/laptop/packages.sh

	link /usr/local/share/fonts/berkeley-mono ~/_/fonts/berkeley-mono --sudo
}

function link() {
	if [[ ${FORCE:-} != 'yes' && -e $1 ]]; then
		echo -e "[\033[37mskip\033[0m] $1 => $2"
		return
	fi
	sudoexec=$(if [[ ${@} =~ "--sudo" ]]; then echo "sudo"; fi)
	$sudoexec rm -rf $1 || true
	$sudoexec mkdir -p $(dirname $1)
	(cd $(dirname $1) && $sudoexec ln -sf $2 $(basename $1))
	echo -e "[\033[32mlink\033[0m] $1 => $2"
}

main
