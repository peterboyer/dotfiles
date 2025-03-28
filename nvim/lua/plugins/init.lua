return {
	-- text object for current line (l)
	{
		"kana/vim-textobj-line",
		dependencies = {
			"kana/vim-textobj-user",
		},
	},

	-- add/change/delete surrounding brackets/quotes/tags
	{ "tpope/vim-surround" },

	-- git tooling (blame)
	{ "tpope/vim-fugitive" },
}
