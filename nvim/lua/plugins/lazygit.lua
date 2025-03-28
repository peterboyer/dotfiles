local keys = {
	{ "<leader>lg", ":LazyGit<cr>", silent = true, desc = "LazyGit" },
}

return {
	"kdheepak/lazygit.nvim",
	keys = keys,
	cmd = {
		"LazyGit",
		"LazyGitConfig",
		"LazyGitCurrentFile",
		"LazyGitFilter",
		"LazyGitFilterCurrentFile",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}
