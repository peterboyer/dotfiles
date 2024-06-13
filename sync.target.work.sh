log set install.homebrew
if $g_cond_install && [[ -z $(command -v brew) ]]; then
	log task
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	log done
else
	log skip
fi

log set install.oh-my-zsh
if $g_cond_install && [[ ! -d ~/.oh-my-zsh ]]; then
	log task
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	log done
else
	log skip
fi

log set install.brewfile
if $g_cond_install; then
	log task
	brew bundle install --file=./os/user.packages.brewfile
	log done
else
	log skip
fi

log set link
if $g_cond_link; then
	log task
	dotbot -c ./dotbot.yaml
	dotbot -c ./dotbot.work.yaml
	log done
else
	log skip
fi
