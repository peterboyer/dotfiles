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

if [[ "$@" =~ "--lfs" ]]; then
cat << EOF >> ~/.gitconfig
[filter "lfs"]
	clean = git-lfs clean -- %f
	smudge = git-lfs smudge -- %f
	process = git-lfs filter-process
	required = true
EOF
fi

if [[ "$@" =~ "--alias" ]]; then
cat << EOF >> ~/.gitconfig
[alias]
	# stash staged
	ss = "!f() { git stash -- \$(git diff --staged --name-only); }; f"
EOF
fi

cat ~/.gitconfig
