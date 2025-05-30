{ stdenv
, lib
, fetchgit
, pkg-config
, autoPatchelfHook
, installShellFiles
, scons
, vulkan-loader
, libGL
, libX11
, libXcursor
, libXinerama
, libXext
, libXrandr
, libXrender
, libXi
, libXfixes
, libxkbcommon
, alsa-lib
, libpulseaudio
, dbus
, speechd
, fontconfig
, udev
, withDebug ? false
, withPlatform ? "linuxbsd"
, withTarget ? "editor"
, withPrecision ? "single"
, withPulseaudio ? true
, withDbus ? true
, withSpeechd ? true
, withFontconfig ? true
, withUdev ? true
, withTouch ? true
}:

assert lib.asserts.assertOneOf "withPrecision" withPrecision [ "single" "double" ];

let
  mkSconsFlagsFromAttrSet = lib.mapAttrsToList (k: v:
    if builtins.isString v
    then "${k}=${v}"
    else "${k}=${builtins.toJSON v}");
in
stdenv.mkDerivation rec {
  pname = "godot4";
  version = "4.4.0-dev4";
  commitHash = "36e6207bb48fafd43b98a458d0c461ad982b4e68";

  src = fetchgit {
    url = "https://github.com/godotengine/godot";
    rev = commitHash;
    sha256 = "sha256-AHzTiO+vItA0p42HtMgHg55V0vhOP+aIDTncPVFie70=";
  };

  nativeBuildInputs = [
    pkg-config
    autoPatchelfHook
    installShellFiles
  ];

  buildInputs = [
    scons
  ];

  runtimeDependencies = [
    vulkan-loader
    libGL
    libX11
    libXcursor
    libXinerama
    libXext
    libXrandr
    libXrender
    libXi
    libXfixes
    libxkbcommon
    alsa-lib
  ]
  ++ lib.optional withPulseaudio libpulseaudio
  ++ lib.optional withDbus dbus
  ++ lib.optional withDbus dbus.lib
  ++ lib.optional withSpeechd speechd
  ++ lib.optional withFontconfig fontconfig
  ++ lib.optional withFontconfig fontconfig.lib
  ++ lib.optional withUdev udev;

  enableParallelBuilding = true;

  # Set the build name which is part of the version. In official downloads, this
  # is set to 'official'. When not specified explicitly, it is set to
  # 'custom_build'. Other platforms packaging Godot (Gentoo, Arch, Flatpack
  # etc.) usually set this to their name as well.
  #
  # See also 'methods.py' in the Godot repo and 'build' in
  # https://docs.godotengine.org/en/stable/classes/class_engine.html#class-engine-method-get-version-info
  BUILD_NAME = "nixpkgs";

  # Required for the commit hash to be included in the version number.
  #
  # `methods.py` reads the commit hash from `.git/HEAD` and manually follows
  # refs. Since we just write the hash directly, there is no need to emulate any
  # other parts of the .git directory.
  #
  # See also 'hash' in
  # https://docs.godotengine.org/en/stable/classes/class_engine.html#class-engine-method-get-version-info
  preConfigure = ''
    mkdir -p .git
    echo ${commitHash} > .git/HEAD
  '';

	GODOT_VERSION_STATUS = "sha";

  sconsFlags = mkSconsFlagsFromAttrSet {
    # Options from 'SConstruct'
    production = true; # Set defaults to build Godot for use in production
    platform = withPlatform;
    target = withTarget;
    precision = withPrecision; # Floating-point precision level
    debug_symbols = withDebug;

    # Options from 'platform/linuxbsd/detect.py'
    pulseaudio = withPulseaudio; # Use PulseAudio
    dbus = withDbus; # Use D-Bus to handle screensaver and portal desktop settings
    speechd = withSpeechd; # Use Speech Dispatcher for Text-to-Speech support
    fontconfig = withFontconfig; # Use fontconfig for system fonts support
    udev = withUdev; # Use udev for gamepad connection callbacks
    touch = withTouch; # Enable touch events
  };

  dontStrip = withDebug;

  outputs = [ "out" "man" ];

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/bin"
    cp bin/godot.* $out/bin/godot4

    installManPage misc/dist/linux/godot.6

    mkdir -p "$out"/share/{applications,icons/hicolor/scalable/apps}
    cp misc/dist/linux/org.godotengine.Godot.desktop "$out/share/applications/org.godotengine.Godot4.desktop"
    substituteInPlace "$out/share/applications/org.godotengine.Godot4.desktop" \
      --replace "Exec=godot" "Exec=$out/bin/godot4" \
      --replace "Godot Engine" "Godot Engine 4"
    cp icon.svg "$out/share/icons/hicolor/scalable/apps/godot.svg"
    cp icon.png "$out/share/icons/godot.png"

    runHook postInstall
  '';

  meta = {
    homepage = "https://godotengine.org";
    description = "Free and Open Source 2D and 3D game engine";
    license = lib.licenses.mit;
    platforms = [ "i686-linux" "x86_64-linux" "aarch64-linux" ];
    maintainers = with lib.maintainers; [ shiryel superherointj ];
    mainProgram = "godot4";
  };
}
