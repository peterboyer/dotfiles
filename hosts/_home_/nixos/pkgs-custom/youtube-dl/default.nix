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
		rev = "16f5bbc464602773e61eeafef51d1dbc47987bb4";
		sha256 = "sha256-WmtAxtD1wnEX5rxspWE6YQ147usCgDZ5TtAxbAj/6E4=";
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
