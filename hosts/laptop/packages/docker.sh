#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

if ! (command -v docker >/dev/null 2>&1); then
	sudo dnf install -y \
		docker-ce \
		docker-ce-cli \
		containerd.io \
		docker-buildx-plugin \
		docker-compose-plugin

	sudo groupadd docker || true
	sudo usermod -aG docker $USER || true

	sudo systemctl enable --now docker.service || true
	sudo systemctl enable --now containerd.service || true
fi
