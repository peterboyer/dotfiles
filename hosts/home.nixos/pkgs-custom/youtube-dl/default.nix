{ stdenv
, lib
, fetchgit
, zip
, gnumake
, python3
, pandoc
, makeWrapper
, ffmpeg }:
stdenv.mkDerivation rec {
	pname = "youtube-dl";
	version = "0.0.0-a08f2b7";

	src = fetchgit {
		url = "https://github.com/ytdl-org/youtube-dl";
		rev = "c5098961b04ce83f4615f2a846c84f803b072639";
		sha256 = "sha256-bR3ns7mnavRXeZazAIuF8FmUXeWSiB7+zdtBpSKTtiw=";
	};

	buildInputs = [
		zip
		gnumake
		python3
		pandoc

		makeWrapper
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
			--prefix PATH : ${lib.makeBinPath [ ffmpeg ]}
	'';
}
