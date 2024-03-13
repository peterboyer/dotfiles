{ config, pkgs, ... }:

{
	home.packages = with pkgs; [ lazygit ];
	home.file.".config/lazygit".source = import ../../utils/link.nix config "/lazygit";
}
