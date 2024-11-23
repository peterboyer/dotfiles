#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

base=$(dirname $(readlink -f $0))

nix flake update $base
