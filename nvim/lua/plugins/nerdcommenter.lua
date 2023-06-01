return {
	{
		lazy = true,
		"preservim/nerdcommenter",
		config = function()
			vim.cmd([[
				let g:NERDSpaceDelims = 1
				let g:NERDDefaultAlign = 'left'
			]])
		end,
	},
}
