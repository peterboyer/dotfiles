#!/usr/bin/env bash

GIT_NAME="$(git config --global user.name)"
GIT_EMAIL="$(git config --global user.email)"

if [[ -z "$GIT_NAME" ]]; then read -p "user.name: " GIT_NAME; fi
if [[ -z "$GIT_EMAIL" ]]; then read -p "user.email: " GIT_EMAIL; fi

cat << EOF > ~/.gitconfig
[user]
	name = $GIT_NAME
	email = $GIT_EMAIL
[core]
	editor = nvim
[init]
	defaultBranch = main
[pull]
	rebase = true
EOF

cat ~/.gitconfig
