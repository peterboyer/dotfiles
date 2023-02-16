local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local menubar = require("menubar")

local M = function (context)
	return {
		awesome_help = function ()
			hotkeys_popup.show_help()
		end,
		awesome_restart = function ()
			awesome.restart()
		end,
		awesome_quit = function ()
			awesome.quit()
		end,

		menu_open = function ()
			context.menu:show({ coords = { x = 0, y = 0 } })
		end,
		menubar_open = function ()
			menubar.show()
		end,
		terminal_spawn = function ()
			awful.spawn(context.terminal)
		end,
		prompt_open = function ()
			awful.screen.focused()[context.prompt]:run()
		end,
		clientlist_open = function ()
			awful.menu.client_list({ theme = { width = 250 } })
		end,

		tag_view_next = function ()
			awful.tag.viewnext()
		end,
		tag_view_prev = function ()
			awful.tag.viewprev()
		end,
		tag_view = function (tag_or_index)
			local tag = tag_or_index
			if type(tag) == "number" then
				local screen = awful.screen.focused()
				tag = screen.tags[tag_or_index]
			end
			if tag then
				tag:view_only()
			end
		end,
		tag_toggle = function (tag_or_index)
			local tag = tag_or_index
			if type(tag) == "number" then
				local screen = awful.screen.focused()
				tag = screen.tags[tag_or_index]
			end
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end,
		tag_move_current_client = function (tag_or_index)
			if client.focus then
				local tag = tag_or_index
				if type(tag) == "number" then
					tag = client.focus.screen.tags[tag_or_index]
				end
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end,
		tag_toggle_current_client = function (tag_or_index)
			if client.focus then
				local tag = tag_or_index
				if type(tag) == "number" then
					tag = client.focus.screen.tags[tag_or_index]
				end
				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end,

		client_focus_next = function ()
			awful.client.focus.byidx(1)
		end,
		client_focus_prev = function ()
			awful.client.focus.byidx(-1)
		end,
		client_focus_urgent = function ()
			awful.client.urgent.jumpto()
		end,
		client_focus_alt = function ()
			awful.client.focus.history.previous()
			if client.focus then
				client.focus:raise()
			end
		end,
		client_swap_next = function ()
			awful.client.swap.byidx(1)
		end,
		client_swap_prev = function ()
			awful.client.swap.byidx( -1)
		end,
		client_unhide = function ()
			local client = awful.client.restore()
			if client then
				client:emit_signal( "request::activate", "key.unminimize", { raise = true })
			end
		end,

		layout_next = function ()
			awful.layout.inc(1)
		end,
		layout_prev = function ()
			awful.layout.inc(-1)
		end,

		audio_volume_up = function ()
			awful.util.spawn("pactl set-sink-volume @DEFAULT_SINK@ +10%")
		end,
		audio_volume_down = function ()
			awful.util.spawn("pactl set-sink-volume @DEFAULT_SINK@ -10%")
		end,
		audio_volume_mute = function ()
			awful.util.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")
		end,

		screen_brightness_up = function ()
			awful.util.spawn("brightnessctl set +10%")
		end,
		screen_brightness_down = function ()
			awful.util.spawn("brightnessctl set 10%-")
		end,

		client_kill = function (c)
			c:kill()
		end,
		client_center = function (c)
			awful.placement.centered(c)
		end,
		client_hide = function (c)
			c.minimized = true
		end,
		client_toggle_fullscreen = function (c)
			c.fullscreen = not c.fullscreen
			c:raise()
		end,
		client_toggle_ontop = function (c)
			c.ontop = not c.ontop
		end,
		client_toggle_maximized = function (c)
			c.maximized = not c.maximized
			c:raise()
		end,
		client_toggle_maximized_vertical = function (c)
			c.maximized_vertical = not c.maximized_vertical
			c:raise()
		end,
		client_toggle_maximized_horizontal = function (c)
			c.maximized_horizontal = not c.maximized_horizontal
			c:raise()
		end ,
		client_toggle_floating = function (c)
			awful.client.floating.toggle(c)
		end,

		client_focus = function (c)
			c:emit_signal("request::activate", "mouse_click", {raise = true})
		end,
		client_move = function (c)
			c:emit_signal("request::activate", "mouse_click", {raise = true})
			awful.mouse.client.move(c)
		end,
		client_resize = function (c)
			c:emit_signal("request::activate", "mouse_click", {raise = true})
			awful.mouse.client.resize(c)
		end,

		client_titlebar_move = function (c)
			c:emit_signal("request::activate", "titlebar", {raise = true})
			awful.mouse.client.move(c)
		end,
		client_titlebar_resize = function (c)
			c:emit_signal("request::activate", "titlebar", {raise = true})
			awful.mouse.client.resize(c)
		end,

		client_tasklist_focus = function (c)
			if c == client.focus then
				c.minimized = true
			else
				c:emit_signal("request::activate", "tasklist", { raise = true })
			end
		end,
	}
end

return M
