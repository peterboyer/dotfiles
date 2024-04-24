{

	# TODO
	# - Shortcuts
	# - Default Applications

	shortcuts = {};

	# https://discourse.nixos.org/t/how-to-configure-kde-properly-in-nix/21362/6

	# System Settings > Shortcuts > kitty
	# - Meta+Return

	# System Settings > Shortcuts > KRunner
	# - Meta+Space

	# System Settings > Shortcuts > KWin
	# - Meta+Q => Quit

	# System Settings > Shortcuts > KWin
	# - Meta+G => Minimise Window
	# - Meta+Tab => Walk Through Windows
	# - Meta+Shift+Tab => Walk Through Windows (Reverse)
	# - Meta+` => Walk Through Windows of Current Application
	# - Meta+~ => Walk Through Windows of Current Application (Reverse)

	# System Settings > Shortcuts > Flameshot
	# - Meta+$ => Take screenshot

	# System Settings > Shortcuts > Audio Volume
	# - Meta+PgUp => Increase Volumne
	# - Meta+PgDown => Decrease Volume
	# - Meta+Shift+PgDown => Mute

	# System Settings > Shortcuts > Media Controller
	# - Meta+] => Media playback next
	# - Meta+[ => Media playback previous
	# - Meta+/ => Play/Pause media playback

	# System Settings > Window Management > Window Behaviour > Task Switcher
	# - Disable => Show selected window
	# - Enabled, "Compact" => Visualisation

	# ~/.config/kwinrc
	# ~/.config/kglobalshortcutsrc
	# "Switch to Window to the Left" = Meta+H
	# "Switch to Window to the Right" = Meta+L
	# "Close Window" = Meta+W
	# "Quit" = Meta+Q
	# "Kill Window" = Meta+Esc

	default_applications = {};

	# terminal kitty
}
