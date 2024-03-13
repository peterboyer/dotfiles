{ lib, stdenvNoCC }:

stdenvNoCC.mkDerivation {
	pname = "berkeley-mono";
	version = "1.009";

	src = ../../../fonts/berkeley-mono-typeface.zip;

	dontPatch = true;
	dontConfigure = true;
	dontBuild = true;
	dontCheck = true;
	dontFixup = true;

	installPhase = ''
		runHook preInstall
		install -Dm644 -t $out/share/fonts/opentype/ berkeley-mono/OTF/*.otf
		install -Dm644 -t $out/share/fonts/truetype/ berkeley-mono/TTF/*.ttf
		install -Dm644 -t $out/share/fonts/truetype/ berkeley-mono-variable/*.ttf
		runHook postInstall
	'';

	meta = with lib; {
		description = "A love letter to the golden era of computing.";
		homepage = "https://berkeleygraphics.com/typefaces/berkeley-mono/";
		changelog = "https://berkeleygraphics.com/typefaces/berkeley-mono/release-notes/";
		license = {
			fullName = "Berkeley Mono FX-100 - Personal Developer License";
			url = "https://berkeleygraphics.com/products/FX-100/";
			free = false;
		};
		platforms = platforms.all;
	}
}
