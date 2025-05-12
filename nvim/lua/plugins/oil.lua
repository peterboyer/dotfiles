local keys = {
	{ "-", ":Oil<cr>", silent = true, desc = "Oil" },
}

--
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
--

return {
	{
		"stevearc/oil.nvim",
		keys = keys,
		config = function()
			require("oil").setup({
				delete_to_trash = vim.loop.os_uname().sysname == "Linux",
				view_options = {
					show_hidden = true,
					sort = { { "name", "asc" } },
				},
				keymaps = {
					["<C-c>"] = false,
					["<C-q>"] = { "actions.send_to_qflist" },
					["YY"] = { "actions.copy_entry_path" },
					["<leader>YY"] = { "actions.copy_to_system_clipboard" },
				},
			})
		end,
	},
}
