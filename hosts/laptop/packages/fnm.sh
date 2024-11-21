#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

if ! (command -v fnm >/dev/null 2>&1); then
    out=~/.local/share/fnm
    src=https://github.com/Schniz/fnm/releases/download/v1.38.1/fnm-linux.zip
    tmp=$(mktemp)
    curl $src -L -o $tmp
    unzip $tmp -d $out
    rm $tmp
    (cd ~/.local/bin && ln -sf $out/*)
    fnm install 22
fi
