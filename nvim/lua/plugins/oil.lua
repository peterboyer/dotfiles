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
				view_options = {
					show_hidden = true,
					keymaps = {
						["<C-c>"] = false,
					}
				}
			})
			keymap()
		end,
	},
}
