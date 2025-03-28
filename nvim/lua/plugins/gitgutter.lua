local keys = {
	{ "]c", ":GitGutterNextHunk<cr>", silent = true, desc = "GitGutter Hunk Next" },
	{ "[c", ":GitGutterPrevHunk<cr>", silent = true, desc = "GitGutter Hunk Prev" },
	{ "<leader>yp", ":GitGutterPreviewHunk<cr>", silent = true, desc = "GitGutter Hunk Preview" },
	{ "<leader>yu", ":GitGutterUndoHunk<cr>", silent = true, desc = "GitGutter Hunk Reset" },
	{ "<leader>ys", ":GitGutterStageHunk<cr>", silent = true, desc = "GitGutter Hunk Stage" },
}

--
vim.g.gitgutter_map_keys = 0
vim.g.gitgutter_sign_added = "█"
vim.g.gitgutter_sign_modified = "█"
vim.g.gitgutter_sign_removed = "█"
vim.g.gitgutter_sign_removed_first_line = "█"
vim.g.gitgutter_sign_removed_above_and_below = "█"
vim.g.gitgutter_sign_modified_removed = "█"
--

return {
	{
		"airblade/vim-gitgutter",
		keys = keys,
		lazy = false,
		config = function()
			-- add rounded border to git preview window
			vim.cmd([[
				let g:gitgutter_floating_window_options["border"] = "rounded"
			]])

			-- @workaround
			-- Marks not updated on buffer write.
			-- https://github.com/airblade/vim-gitgutter/issues/526
			vim.cmd("autocmd BufWritePost * GitGutter")
		end,
	},
}
