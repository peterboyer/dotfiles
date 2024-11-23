#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

if ! (sudo snapper get-config >/dev/null 2>&1); then
	sudo snapper create-config / \
	&& sudo snapper set-config TIMELINE_CREATE=no \
	&& sudo snapper get-config \
	&& sudo snapper create
fi
