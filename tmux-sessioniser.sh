#!/usr/bin/env zsh

dirs="$(find ~/_dev -mindepth 1 -maxdepth 1 -type d)"
dirs+="\n$HOME/_dotfiles"

selected=${1:-$(echo $dirs | fzf)}
selected=${selected:?no target}

name=$(basename "$selected" | tr . _)

if ! tmux has-session -t=$name 2> /dev/null; then
	tmux new-session -d -s $name -c $selected
fi

if [[ -z $TMUX ]]; then
	tmux attach-session -t $name
else
	tmux switch-client -t $name
fi
