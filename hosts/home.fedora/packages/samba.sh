#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

if ! (command -v smbpasswd >/dev/null 2>&1); then
	sudo dnf install -y samba
	sudo systemctl enable smb.service --now || true

	firewall-cmd --get-active-zones
	sudo firewall-cmd \
			--permanent \
			--zone=FedoraWorkstation \
			--add-service=samba
	sudo firewall-cmd --reload

	sudo smbpasswd -a $USER

	dot_share_path=/home/$USER/_/share
	mkdir -p $dot_share_path
	sudo semanage fcontext \
		--add \
		--type "samba_share_t" \
		"$dot_share_path(/.*)?"

	sudo restorecon -R $dot_share_path

	sudo systemctl restart smb.service
fi
