#!/bin/bash

mkdir -p ./git-repos
(cd git-repos && git init --bare dotfiles.git)
git remote add mirror ./git-repos/dotfiles.git
git push mirror main
