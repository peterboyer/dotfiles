{ config, pkgs, ... }:

{
	home.packages = with pkgs; [ tmux ];
	home.file.".tmux.conf".source = import ../../utils/link.nix config "/tmux/tmux.conf";
}
