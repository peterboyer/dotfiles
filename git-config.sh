#!/bin/bash

if [[ "$@" =~ "--help" ]]; then
  echo "usage: [<options>]"
  echo "  --ask         read name/email from prompts"
  echo "  --repo        read name/email from HEAD commit"
  echo "  --lfs         include git-lfs filter options"
  echo "  --alias       include helper command aliases"
  exit
fi

GIT_CONFIG_NAME="$(git config --global user.name)"
GIT_CONFIG_EMAIL="$(git config --global user.email)"

GIT_REPO_NAME="$(git log -n 1 --format='%an')"
GIT_REPO_EMAIL="$(git log -n 1 --format='%aE')"

if [[ "$@" =~ "--repo" ]]; then
  GIT_CONFIG_NAME=""
  GIT_CONFIG_EMAIL=""
fi

GIT_NAME="${GIT_CONFIG_NAME:-$GIT_REPO_NAME}"
GIT_EMAIL="${GIT_CONFIG_EMAIL:-$GIT_REPO_EMAIL}"

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

if [[ "$@" =~ "--alias" ]]; then
cat << EOF >> ~/.gitconfig
[alias]
	# stash staged
	ss = "!f() { git stash -- \$(git diff --staged --name-only); }; f"
	serve = "!f() { zsh $HOME/_dotfiles/git/serve.sh; }; f"
EOF
fi

cat ~/.gitconfig
