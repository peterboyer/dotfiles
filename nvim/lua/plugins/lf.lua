return {
	{
		lazy = true,
		"lmburns/lf.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"akinsho/toggleterm.nvim",
		},
		config = function()
			require("lf").setup({
				border = "curved",
				winblend = 0, -- background fix
				default_cmd = 'lf -command "set hidden"', -- show hidden files
			})

			vim.keymap.set("n", "<leader>E", ":Lf<CR>")
		end,
	},
}
