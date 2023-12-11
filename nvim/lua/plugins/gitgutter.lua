-- @workaround
-- Config must happen _before_ the plugin is initialised.
vim.cmd([[
	let g:gitgutter_sign_added                   = '█'
	let g:gitgutter_sign_modified                = '█'
	let g:gitgutter_sign_removed                 = '█'
	let g:gitgutter_sign_removed_first_line      = '█'
	let g:gitgutter_sign_removed_above_and_below = '█'
	let g:gitgutter_sign_modified_removed        = '█'
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
