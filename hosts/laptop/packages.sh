#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

packages=(
	git
	eza
	fzf
	tmux
	kitty
	fastfetch

	neovim
		ripgrep
		./packages/fnm.sh

	lazygit
		copr:atim/lazygit

	brave-browser
		https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
		https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
)

base=$(dirname $0)
packages_lock=()
packages_lock_path=~/.local/state/packages.lock
if [[ -r $packages_lock_path ]]; then
	readarray -t packages_lock < $packages_lock_path
fi

declare -A packages_map
for name in "${packages_lock[@]}"; do
	packages_map[$name]="false"
done

coprs=()
repos=()
keys=()
srcs=()
for name in "${packages[@]}"; do
	if [[ $name == copr:* ]]; then
		coprs+=(${name#copr:})
	elif [[ $name == *.repo ]]; then
		repos+=($name)
	elif [[ $name == *.asc ]]; then
		keys+=($name)
	elif [[ $name == ./* ]]; then
		srcs+=($name)
	else
		packages_map[$name]="true"
	fi
done

packages_install=()
packages_remove=()
for name in "${!packages_map[@]}"; do
	if [[ ${packages_map[$name]} == "true" ]]; then
		packages_install+=($name)
	else
		packages_remove+=($name)
	fi
done

for name in "${coprs[@]}"; do
	if [[ -z "$(dnf copr list | grep $name)" ]]; then
		sudo dnf copr enable -y $name
	fi
done

for name in "${repos[@]}"; do
	if [[ ! -e /etc/yum.repos.d/$(basename $name) ]]; then
		tmp=$(mktemp)
		rm $tmp
		mkdir -p $tmp
		curl $name -L | grep --invert-match autorefresh > $tmp/$(basename $name)
		sudo dnf config-manager addrepo --from-repofile=$tmp/$(basename $name)
	fi
done

for name in "${keys[@]}"; do
	sudo rpm --import $name
done

if [[ ${#packages_remove[@]} != 0 ]]; then
	sudo dnf remove -y ${packages_remove[@]}
fi

if [[ ${#packages_install[@]} != 0 ]]; then
	sudo dnf install -y ${packages_install[@]}
fi

for name in "${srcs[@]}"; do
	$base/$name
done

(rm $packages_lock_path >/dev/null 2>&1) || true
for name in "${packages_install[@]}"; do
	echo $name >> $packages_lock_path
done
