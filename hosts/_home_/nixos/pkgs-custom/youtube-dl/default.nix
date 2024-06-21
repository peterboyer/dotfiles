{
  pkgs ? import (fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/12430e43bd9b81a6b4e79e64f87c624ade701eaf.tar.gz";
    sha256 = "sha256:1ry06nhk8ayfb7wjmkacz8zqk0hwvp9phyachbkxsyxgc0hj3y6z";
  }) {}
}:
pkgs.stdenv.mkDerivation rec {
	pname = "youtube-dl";
	version = "0.0.0-a08f2b7";

	src = pkgs.fetchgit {
		url = "https://github.com/ytdl-org/youtube-dl";
		rev = "a08f2b7e4567cdc50c0614ee0a4ffdff49b8b6e6";
		sha256 = "sha256-gbTB3FsMEmA6+Np418yRUXk+1jZUFenCPdu765vb49s=";
	};

	buildInputs = [
		pkgs.zip
		pkgs.gnumake
		pkgs.python3
		pkgs.pandoc

		pkgs.makeWrapper
	];

	buildPhase = ''
		mv Makefile Makefile.source
		sed 's/\/usr\/bin\/env //' Makefile.source > Makefile
		make
	'';

	installPhase = ''
		mkdir -p $out/bin
		mv youtube-dl $out/bin
		wrapProgram $out/bin/youtube-dl \
			--prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.ffmpeg ]}
	'';
}
