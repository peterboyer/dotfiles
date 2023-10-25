-- @workaround
-- Setting any `sign_*` options only seems to work _before_ the plugin is initialised.
vim.cmd([[
	let g:gitgutter_sign_removed = "-"
]])

return {
	{
		"airblade/vim-gitgutter",
		config = function()
			vim.cmd([[
				let g:gitgutter_floating_window_options["border"] = "rounded"
			]])
		end,
	},
}
