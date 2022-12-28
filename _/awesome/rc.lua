pcall(require, "luarocks.loader")

local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

require("awful.autofocus")
require("awful.hotkeys_popup.keys")

beautiful.init(gears.filesystem.get_configuration_dir() .. "default/theme.lua")

local tags = 4
local modkey = "Mod4"

local terminal = "alacritty"
menubar.utils.terminal = terminal

local editor = os.getenv("EDITOR") or "nvim"
local editor_cmd = terminal .. " -e " .. editor

awful.layout.layouts = {
	awful.layout.suit.floating,
	awful.layout.suit.tile,
	awful.layout.suit.tile.left,
	awful.layout.suit.tile.bottom,
	awful.layout.suit.tile.top,
	awful.layout.suit.fair,
	awful.layout.suit.fair.horizontal,
	awful.layout.suit.spiral,
	awful.layout.suit.spiral.dwindle,
	awful.layout.suit.max,
	awful.layout.suit.max.fullscreen,
	awful.layout.suit.magnifier,
	awful.layout.suit.corner.nw,
}

local launcher_menu = awful.menu({
	items = {
		{ "suspend", "systemctl suspend" },
		{ "awesome", {
			{ "hotkeys", function () hotkeys_popup.show_help(nil, awful.screen.focused()) end },
			{ "config", editor_cmd .. " " .. awesome.conffile },
			{ "manual", terminal .. " -e man awesome" },
			{ "restart", awesome.restart },
			{ "quit", function () awesome.quit() end },
		}, beautiful.awesome_icon },
		{ "reboot", "systemctl reboot" },
		{ "shutdown", "systemctl poweroff" }
	}
})

local actions = require("actions") {
	menu = launcher_menu,
	terminal = terminal,
	prompt = "prompt",
}

local function set_wallpaper(screen)
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper
		if type(wallpaper) == "function" then
			wallpaper = wallpaper(screen)
		end
		gears.wallpaper.centered(wallpaper, screen)
	end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(screen)
	set_wallpaper(screen)

	local tag_titles = {}
	for i = 1, tags do
		tag_titles[i] = " " .. i .. " "
	end
	awful.tag(tag_titles, screen, awful.layout.layouts[1])

	local bar = awful.wibar({
		position = "top",
		screen = screen,
		bg = "#212121",
	})

	local prompt = awful.widget.prompt {}
	screen.prompt = prompt

	bar:setup {
		layout = wibox.layout.align.horizontal,
		{
			layout = wibox.layout.fixed.horizontal,
			spacing = 10,

			awful.widget.launcher {
				image = beautiful.awesome_icon,
				menu = launcher_menu
			},
			awful.widget.taglist {
				screen = screen,
				filter = awful.widget.taglist.filter.all,
				buttons = gears.table.join(
					awful.button({}, 1, actions.tag_view),
					awful.button({ modkey }, 1, actions.tag_move_current_client),
					awful.button({}, 3, actions.tag_toggle),
					awful.button({ modkey }, 3, actions.tag_toggle_current_client),
					awful.button({}, 4, actions.tag_view_next),
					awful.button({}, 5, actions.tag_view_prev)
				),
			},
			prompt,
			awful.widget.tasklist {
				screen = screen,
				filter = awful.widget.tasklist.filter.currenttags,
				buttons = gears.table.join(
					awful.button({}, 1, actions.client_tasklist_focus),
					awful.button({}, 3, actions.clientlist_open),
					awful.button({}, 4, actions.client_focus_next),
					awful.button({}, 5, actions.client_focus_prev)
				),
			},
		},
		{
			layout = wibox.layout.flex.horizontal,
		},
		{
			layout = wibox.layout.fixed.horizontal,
			spacing = 10,

			wibox.widget.systray {},
			require("battery-widget") {},
			wibox.widget.textclock("[%Y-%m-%d %H:%M]"),
			(function ()
				local layoutbox = awful.widget.layoutbox(screen)
				layoutbox:buttons(gears.table.join(
					awful.button({}, 1, function () awful.layout.inc( 1) end),
					awful.button({}, 3, function () awful.layout.inc(-1) end),
					awful.button({}, 4, function () awful.layout.inc( 1) end),
					awful.button({}, 5, function () awful.layout.inc(-1) end)
				))
				return layoutbox
			end)(),
		},
	}
end)

-- GLOBAL

local globalkeys = gears.table.join(
	awful.key({ modkey }, "s", actions.awesome_help, { description = "show help", group="awesome" }),
	awful.key({ modkey, "Control" }, "r", actions.awesome_restart, { description = "reload awesome", group = "awesome" }),
	awful.key({ modkey, "Shift" }, "q", actions.awesome_quit, { description = "quit awesome", group = "awesome" }),

	awful.key({ modkey }, "Escape", actions.menu_open, { description = "show main menu", group = "launcher" }),
	awful.key({ modkey }, "space", actions.menubar_open, { description = "show the menubar", group = "launcher" }),
	awful.key({ modkey }, "Return", actions.terminal_spawn, { description = "open a terminal", group = "launcher" }),
	awful.key({ modkey }, "r", actions.prompt_open, { description = "run prompt", group = "launcher" }),

	awful.key({ modkey }, "Right", actions.tag_view_next, { description = "view next", group = "tag" }),
	awful.key({ modkey }, "Left", actions.tag_view_prev, { description = "view previous", group = "tag" }),

	awful.key({ modkey }, "j", actions.client_focus_next, { description = "focus next by index", group = "client" }),
	awful.key({ modkey }, "k", actions.client_focus_prev, {  description = "focus previous by index", group = "client" }),
	awful.key({ modkey }, "u", actions.client_focus_urgent, { description = "jump to urgent client", group = "client" }),
	awful.key({ modkey }, "Tab", actions.client_focus_alt, { description = "go back", group = "client" }),
	awful.key({ modkey, "Shift" }, "j", actions.client_swap_next, { description = "swap with next client by index", group = "client" }),
	awful.key({ modkey, "Shift" }, "k", actions.client_swap_prev, { description = "swap with previous client by index", group = "client" }),
	awful.key({ modkey, "Shift" }, "h", actions.client_unhide, { description = "restore minimized", group = "client" }),

	awful.key({ modkey }, "]", actions.layout_next, { description = "select next", group = "layout" }),
	awful.key({ modkey }, "[", actions.layout_prev, { description = "select previous", group = "layout" }),

	awful.key({ "Mod1" }, "Page_Up", actions.audio_volume_up, { description = "volume up", group = "audio" }),
	awful.key({ "Mod1" }, "Page_Down", actions.audio_volume_down, { description = "volume down", group = "audio" }),
	awful.key({ "Mod1" }, "Delete", actions.audio_volume_mute, { description = "toggle mute", group = "audio" })
)

for i = 1, tags do
	local keycode = "#" .. i + 9
	globalkeys = gears.table.join(
		globalkeys,
		awful.key({ modkey }, keycode, function () actions.tag_view(i) end, { description = "view tag #"..i, group = "tag" }),
		awful.key({ modkey, "Control" }, keycode, function () actions.tag_toggle(i) end, { description = "toggle tag #" .. i, group = "tag" }),
		awful.key({ modkey, "Shift" }, keycode, function () actions.tag_move_current_client(i) end, { description = "move focused client to tag #"..i, group = "tag" }),
		awful.key({ modkey, "Control", "Shift" }, keycode, function () actions.tag_toggle_current_client(i) end, { description = "toggle focused client on tag #" .. i, group = "tag" })
	)
end

root.keys(globalkeys)

-- CLIENT

local clientkeys = gears.table.join(
	awful.key({ modkey, "Shift" }, "c", actions.client_kill, { description = "close", group = "client" }),
	awful.key({ modkey, "Shift" }, "space", actions.client_center, { description = "center", group = "client" }),

	awful.key({ modkey }, "h", actions.client_hide, { description = "minimize", group = "client" }),
	awful.key({ modkey }, "f", actions.client_toggle_fullscreen, {description = "toggle fullscreen", group = "client" }),
	awful.key({ modkey }, "t", actions.client_toggle_ontop, { description = "toggle keep on top", group = "client" }),
	awful.key({ modkey }, "m", actions.client_toggle_maximized, { description = "(un)maximize", group = "client" }),
	awful.key({ modkey, "Control" }, "m", actions.client_toggle_maximized_vertical, { description = "(un)maximize vertically", group = "client" }),
	awful.key({ modkey, "Shift" }, "m", actions.client_toggle_maximized_horizontal, { description = "(un)maximize horizontally", group = "client" }),
	awful.key({ modkey, "Control" }, "space", actions.client_toggle_floating, { description = "toggle floating", group = "client" })
)

local clientbuttons = gears.table.join(
	awful.button({}, 1, actions.client_focus),
	awful.button({ modkey }, 1, actions.client_move),
	awful.button({ modkey }, 3, actions.client_resize)
)

awful.rules.rules = {
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_offscreen,
		},
	},
	{
		rule_any = {
			type = {
				"normal",
				"dialog",
			},
		},
		properties = {
			titlebars_enabled = true,
		},
	},
	{
		rule_any = {
			class = {
				"Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
			},
			name = {
				"Event Tester", -- xev.
			},
			role = {
				"pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
			},
		},
		properties = {
			floating = true,
		},
	},
	{
		rule_any = {
			class = {
				"Alacritty"
			}
		},
		properties = {
			placement = awful.placement.centered,
		}
	}
}

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	-- if not awesome.startup then
		-- awful.client.setslave(c)
	-- end

	-- Prevent clients from being unreachable after screen count changes.
	if awesome.startup
		and not c.size_hints.user_position
		and not c.size_hints.program_position then
		awful.placement.no_offscreen(c)
	end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
	local buttons = gears.table.join(
		awful.button({}, 1, function () actions.client_titlebar_move(c) end),
		awful.button({}, 3, function () actions.client_titlebar_resize(c) end)
	)

	awful.titlebar(c):setup {
		layout = wibox.layout.align.horizontal,
		{
			layout = wibox.layout.fixed.horizontal,
			buttons = buttons,

			awful.titlebar.widget.iconwidget(c),
			awful.titlebar.widget.stickybutton(c),
		},
		{
			layout = wibox.layout.flex.horizontal,
			buttons = buttons,

			{
				widget = awful.titlebar.widget.titlewidget(c),
				align = "center",
			},
		},
		{
			layout = wibox.layout.fixed.horizontal,

			awful.titlebar.widget.floatingbutton(c),
			awful.titlebar.widget.ontopbutton(c),
			awful.titlebar.widget.maximizedbutton(c),
			awful.titlebar.widget.closebutton(c),
		},
	}
end)

client.connect_signal("focus", function(c)
	c.border_color = beautiful.border_focus
end)

client.connect_signal("unfocus", function(c)
	c.border_color = beautiful.border_normal
end)
