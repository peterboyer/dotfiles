log set install.nixos
if $g_cond_install; then
	log task
	sudo nixos-rebuild switch --flake ./os#home --impure
	log done
else
	log skip
fi

log set link
if $g_cond_link; then
	log task
	dotbot -c ./dotbot.yaml
	dotbot -c ./dotbot.home.yaml
	log done
else
	log skip
fi
