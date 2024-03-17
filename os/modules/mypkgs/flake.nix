{
	inputs = {
		nixpkgs = {
			url = "github:nixos/nixpkgs/nixos-23.11";
		};
	};

	outputs = { self, nixpkgs }: let
		pkgs = nixpkgs.legacyPackages.x86_64-linux;
	in {
		berkeley-mono = pkgs.stdenv.mkDerivation {
			pname = "berkeley-mono";
			version = "1.009";

			buildInputs = [ pkgs.unzip ];
			nativeBuildInputs = [ pkgs.unzip ];
			src = ./berkeley-mono-typeface.zip;

			installPhase = ''
				runHook preInstall
				install -Dm644 -t $out/share/fonts/opentype/ berkeley-mono/OTF/*.otf
				install -Dm644 -t $out/share/fonts/truetype/ berkeley-mono/TTF/*.ttf
				install -Dm644 -t $out/share/fonts/truetype/ berkeley-mono-variable/*.ttf
				runHook postInstall
			'';

			meta = {
				description = "A love letter to the golden era of computing.";
				homepage = "https://berkeleygraphics.com/typefaces/berkeley-mono/";
				changelog = "https://berkeleygraphics.com/typefaces/berkeley-mono/release-notes/";
				license = {
					fullName = "Berkeley Mono FX-100 - Personal Developer License";
					url = "https://berkeleygraphics.com/products/FX-100/";
					free = false;
				};
				platforms = nixpkgs.lib.platforms.all;
			};
		};
	};
}
