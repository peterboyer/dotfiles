local keymap = function()
	vim.keymap.set("n", "-", require("oil").open)
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return {
	{
		"stevearc/oil.nvim",
		config = function()
			require("oil").setup({
				delete_to_trash = vim.loop.os_uname().sysname == "Linux",
				view_options = {
					show_hidden = true,
					sort = {
						{ "name", "asc" },
					},
				},
				keymaps = {
					["<C-c>"] = false,
				},
			})
			keymap()
		end,
	},
}
