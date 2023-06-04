local keymap = function() end

vim.cmd([[
	let g:netrw_liststyle = 1
	let g:netrw_sizestyle = "h"
	let g:netrw_timefmt = "%H:%M %F"
]])

return {
	{
		"tpope/vim-vinegar",
		config = function()
			vim.keymap.del("n", "-")
		end,
	},
	{
		"prichrd/netrw.nvim",
		config = function()
			require("netrw").setup({
				use_devicons = true,
			})
			keymap()
		end,
	},
}
