require("telescope").setup {
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
}

local t = require("telescope.builtin")
vim.keymap.set("n", "<leader>p", t.git_files)
vim.keymap.set("n", "<leader>P", t.find_files)
vim.keymap.set("n", "<leader>b", t.buffers)
vim.keymap.set("n", "<leader>o", t.oldfiles)
vim.keymap.set("n", "<leader>fg", t.live_grep)
vim.keymap.set("n", "<leader>fh", t.help_tags)
vim.keymap.set("n", "<leader>fs", t.git_status)
