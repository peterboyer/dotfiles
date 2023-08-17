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
				},
				keymaps = {
					["<C-c>"] = false,
				},
			})
			keymap()
		end,
	},
}

-- disable sorting directories to top (remove lines 394-398)
-- https://github.com/stevearc/oil.nvim/blob/8f7807946a67b5f1a515946f82251e33651bae29/lua/oil/view.lua#L393
