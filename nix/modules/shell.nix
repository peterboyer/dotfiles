{ config, pkgs, ... }:

{
	home.packages = with pkgs; [ eza ripgrep fzf ];
	home.file.".zshrc".source = import ../utils/link.nix config "/zsh/zshrc";
}
