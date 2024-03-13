{ config, pkgs, ... }:

{
	home.packages = with pkgs; [ neovim trash-cli nodejs_21 ];
	home.file.".config/nvim".source = import ../../utils/link.nix config "/nvim";
}
