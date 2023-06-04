return {
	{ "nvim-tree/nvim-web-devicons" },
	{
		"kana/vim-textobj-line",
		dependencies = {
			"kana/vim-textobj-user",
		},
	},
	{ "airblade/vim-gitgutter" },
	-- toggle quickfix/locationlist
	{ "milkypostman/vim-togglelist" },
	-- auto closing bracket/quotes
	{ "cohama/lexima.vim" },
	-- add/change/delete surrounding brackets/quotes/tags
	{ "tpope/vim-surround" },
	-- git tooling (blame)
	{ "tpope/vim-fugitive" },
	-- fs tooling (rename buffer and file)
	{ "tpope/vim-eunuch" },
	-- ripgrep into quickfix (:Rg <string|pattern>)
	{ "jremmen/vim-ripgrep" },
	-- delete buffers without messing the layout
	{ "moll/vim-bbye", enabled = false },
}
