#!/bin/bash

if [[ "$@" =~ "--help" ]]; then
  echo "usage: [<options>]"
  echo "  --ask         read name/email from prompts"
  echo "  --existing    read name/email from HEAD commit"
  echo "  --lfs         include git-lfs filter options"
  echo "  --alias       include helper command aliases"
  exit
fi

if [[ "$@" =~ "--existing" ]]; then
	GIT_CONFIG_NAME="$(git config --global user.name)"
	GIT_CONFIG_EMAIL="$(git config --global user.email)"
fi

GIT_NAME="${GIT_CONFIG_NAME:-$(git log -n 1 --format='%an')}"
GIT_EMAIL="${GIT_CONFIG_EMAIL:-$(git log -n 1 --format='%aE')}"

if [[ "$@" =~ "--ask" ]]; then
  GIT_NAME=""
  GIT_EMAIL=""
fi

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

cat ~/.gitconfig
