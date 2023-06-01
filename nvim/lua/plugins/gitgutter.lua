return {
	{
		"airblade/vim-gitgutter",
		config = function()
			vim.cmd([[
				let g:gitgutter_map_keys = 0
			]])
		end,
	},
}
