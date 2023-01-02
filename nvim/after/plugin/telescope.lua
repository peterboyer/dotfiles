require("telescope").setup {
	defaults = {
		path_display = { "truncate" },
		file_ignore_patterns = {
			"%.git/",
			"%.yarn/",
		},
	},
	pickers = {
		find_files = {
			hidden = true, -- dotfiles
			follow = true, -- symlinks
		},
		buffers = {
			show_all_buffers = true,
			sort_lastused = true,
			mappings = {
				i = {
					["<c-d>"] = "delete_buffer",
				},
			},
		},
	},
}

local telescope = require("telescope.builtin")
vim.keymap.set("n", "<leader>p", telescope.find_files)
vim.keymap.set("n", "<leader>P", telescope.oldfiles)
vim.keymap.set("n", "<leader>b", telescope.buffers)
vim.keymap.set("n", "<leader>fg", telescope.live_grep)
vim.keymap.set("n", "<leader>fh", telescope.help_tags)
vim.keymap.set("n", "<leader>fs", telescope.git_status)
