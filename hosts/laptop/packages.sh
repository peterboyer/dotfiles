#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

function main() {
	install git
	install eza
	install fzf
	install ripgrep

	install tmux
	install neovim
	install lazygit
}

fg_reset="\033[0m"
fg_cyan="\033[0;36m"
fg_green="\033[0;32m"
fg_yellow="\033[0;33m"
function install() {
	name=${1:?}
	exists=$(if [[ -n $(apt list $name --installed 2>/dev/null | grep "$name/") ]]; then echo 1; else echo 0; fi)
	name_formatted="${fg_cyan}$name${fg_reset}"
	if [[ $exists == 1 ]]; then
		echo -e "$name_formatted: ${fg_green}installed${fg_reset}"
	else
		echo -e "$name_formatted: ${fg_yellow}installing...${fg_reset}"
		apt install $name -y
	fi
}

main
