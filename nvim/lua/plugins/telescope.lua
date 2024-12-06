local keymap = function()
	local utils = require("telescope.utils")
	local telescope = require("telescope.builtin")
	vim.keymap.set("n", "<leader>b", telescope.buffers)
	vim.keymap.set("n", "<leader>B", telescope.git_status)
	vim.keymap.set("n", "<leader>f", telescope.live_grep)
	vim.keymap.set("n", "<leader>F", function()
		telescope.live_grep({ file_ignore_patterns = { "%.test%.tsx?", "%.spec%.tsx?" } })
	end)
	vim.keymap.set("n", "<leader>g", telescope.help_tags)
	vim.keymap.set("n", "<leader>o", telescope.oldfiles)
	vim.keymap.set("n", "<leader>O", function()
		telescope.oldfiles({ only_cwd = false })
	end)
	vim.keymap.set("n", "<leader>p", telescope.git_files)
	vim.keymap.set("n", "<leader>P", telescope.find_files)
	vim.keymap.set("n", "<leader>i", telescope.lsp_document_symbols)
	vim.keymap.set("n", "<leader>I", telescope.lsp_workspace_symbols)
end

return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local action_state = require("telescope.actions.state")
			require("telescope").setup({
				defaults = {
					path_display = { truncate = 3 },
					file_ignore_patterns = {
						"%.git/",
						"%.yarn/",
					},
				},
				pickers = {
					buffers = {
						sort_mru = true,
						mappings = {
							i = {
								["<c-d>"] = "delete_buffer",
								["<c-x>"] = function(prompt_bufnr)
									-- Based on "delete_buffer" + { force = true }
									-- https://github.com/nvim-telescope/telescope.nvim/blob/4522d7e3ea75ffddabdc39957168a8a7060b5df0/lua/telescope/actions/init.lua#L1176
									local current_picker = action_state.get_current_picker(prompt_bufnr)
									current_picker:delete_selection(function(selection)
										local ok = pcall(vim.api.nvim_buf_delete, selection.bufnr, { force = true })
										return ok
									end)
								end,
							},
						},
					},
					live_grep = {
						additional_args = { "--hidden" },
					},
					oldfiles = {
						only_cwd = true,
					},
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
				},
			})
			keymap()
		end,
	},
}
