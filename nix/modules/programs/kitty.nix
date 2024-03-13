{ config, pkgs, ... }:

{
	home.packages = with pkgs; [ kitty ];
	home.file.".config/kitty".source = import ../../utils/link.nix config "/kitty";
}
