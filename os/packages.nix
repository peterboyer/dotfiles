pkgs:
let custom = pkgs.custom pkgs; in
with pkgs;
{
	shell = zsh;

	sys = [
		gcc
		vim
		git
		wget
		htop
		unzip
		xclip
		killall
	];

	user = [
		eza
		fzf

		tmux
		neovim
		ripgrep
		trash-cli
		nodejs_21
		cargo
		unstable.lazygit
		kitty
		sshfs

		jq
		calc
		cmatrix
		dotbot
		neofetch
		dive
		slides
		ngrok

		monolith

		firefox
		brave
		discord
		slack
		signal-desktop
		spotify
		vlc
		flameshot
		peek
		colorpicker
		pdfarranger
		audacity
		blender
		obs-studio
		remmina
		moonlight-qt

		custom.youtube-dl
	];
}
