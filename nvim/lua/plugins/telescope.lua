return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("telescope").setup({
				defaults = {
					path_display = { truncate = 3 },
					file_ignore_patterns = {
						"%.git/",
						"%.yarn/",
						"%node_modules/",
					},
				},
				pickers = {
					git_files = {
						show_untracked = true,
						use_git_root = false,
					},
					find_files = {
						hidden = true, -- dotfiles
						follow = true, -- symlinks
						no_ignore = true,
						no_ignore_ignore = true,
					},
					live_grep = {
						additional_args = { "--hidden" },
					},
					buffers = {
						sort_lastused = true,
						mappings = {
							i = {
								["<c-d>"] = "delete_buffer",
							},
						},
					},
					oldfiles = {
						only_cwd = true,
					},
				},
			})

			local telescope = require("telescope.builtin")
			vim.keymap.set("n", "<leader>o", telescope.oldfiles)
			vim.keymap.set("n", "<leader>p", telescope.git_files)
			vim.keymap.set("n", "<leader>P", telescope.find_files)
			vim.keymap.set("n", "<leader>f", telescope.live_grep)
			vim.keymap.set("n", "<leader>g", telescope.help_tags)
			vim.keymap.set("n", "<leader>i", telescope.lsp_document_symbols)
			vim.keymap.set("n", "<leader>I", telescope.lsp_workspace_symbols)
		end,
	},
}
