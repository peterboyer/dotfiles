vim.cmd([[
	let g:netrw_liststyle = 1
	let g:netrw_sizestyle = "h"
	let g:netrw_timefmt = "%H:%M %F"

	" augroup InitNetrw
	"   autocmd!
	"   autocmd VimEnter * if expand("%") == "" | edit . | endif
	" augroup END
]])

return {
	{
		"tpope/vim-vinegar",
	},
	{
		"prichrd/netrw.nvim",
		config = function()
			require("netrw").setup({
				use_devicons = true,
			})

			vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
		end,
	},
}
