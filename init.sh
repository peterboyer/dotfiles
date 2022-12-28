#!/usr/bin/env bash

mkdir -p $HOME/_dev
mkdir -p $HOME/_zone

remote="$(cd $HOME/_dotfiles && git remote -v | grep fetch | awk '{print $2}')"
if [[ "$remote" =~ "https://" ]]; then
  (cd $HOME/_dotfiles && git remote set-url origin $(echo $remote | sed 's/https:\/\//git@/' | sed 's/\//:/'))
fi

$(dirname $0)/link.sh
$(dirname $0)/packages.sh bootstrap
