local keys = {
	{ "<leader>p", ":Telescope find_files<cr>" },
	{ "<leader>o", ":Telescope oldfiles<cr>" },
	{ "<leader>f", ":Telescope live_grep<cr>" },

	-- vim
	{ "<leader>b", ":Telescope buffers<cr>" },
	{ "<leader>h", ":Telescope help_tags<cr>" },

	-- git
	{ "<leader>g", ":Telescope git_status<cr>" },

	-- lsp
	{ "<leader>i", ":Telescope lsp_document_symbols<cr>" },
	{ "<leader>I", ":Telescope lsp_workspace_symbols<cr>" },
}

return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = keys,
		config = function()
			require("telescope").setup({
				defaults = {
					path_display = { truncate = 3 },
					file_ignore_patterns = {
						"%.git/",
						"%.yarn/",
						"%.DS_Store",
						"%node_modules/",
					},
				},
				pickers = {
					find_files = {
						hidden = true, -- dotfiles
					},
					oldfiles = {
						only_cwd = true,
					},
					live_grep = {
						additional_args = { "--hidden" },
					},

					buffers = {
						mappings = {
							i = {
								["<c-d>"] = "delete_buffer",
								["<c-x>"] = function(prompt_bufnr)
									-- Based on "delete_buffer" + { force = true }
									-- https://github.com/nvim-telescope/telescope.nvim/blob/4522d7e3ea75ffddabdc39957168a8a7060b5df0/lua/telescope/actions/init.lua#L1176
									local action_state = require("telescope.actions.state")
									local current_picker = action_state.get_current_picker(prompt_bufnr)
									current_picker:delete_selection(function(selection)
										return pcall(vim.api.nvim_buf_delete, selection.bufnr, { force = true })
									end)
								end,
							},
						},
					},
				},
			})
		end,
	},
}
