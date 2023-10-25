return {
	{ "nvim-tree/nvim-web-devicons" },
	{
		"kana/vim-textobj-line",
		dependencies = {
			"kana/vim-textobj-user",
		},
	},
	-- toggle quickfix/locationlist
	{ "milkypostman/vim-togglelist" },
	-- auto closing bracket/quotes
	{ "cohama/lexima.vim" },
	-- add/change/delete surrounding brackets/quotes/tags
	{ "tpope/vim-surround" },
	-- git tooling (blame)
	{ "tpope/vim-fugitive" },
	-- ripgrep into quickfix (:Rg <string|pattern>)
	{ "jremmen/vim-ripgrep" },
}
