return {
	{
		lazy = true,
		"nvim-tree/nvim-web-devicons",
	},
	{
		lazy = true,
		"cappyzawa/trim.nvim",
		config = function()
			require("trim").setup({})
		end,
	},
	{
		lazy = true,
		"kana/vim-textobj-line",
		dependencies = {
			"kana/vim-textobj-user",
		},
	},
	-- toggle quickfix/locationlist
	{
		lazy = true,
		"milkypostman/vim-togglelist",
	},
	-- auto closing bracket/quotes
	{
		lazy = true,
		"cohama/lexima.vim",
	},
	-- add/change/delete surrounding brackets/quotes/tags
	{
		lazy = true,
		"tpope/vim-surround",
	},
	-- delete buffers without messing the layout
	{
		enabled = false,
		"moll/vim-bbye",
	},
	-- git tooling (blame)
	{
		lazy = true,
		"tpope/vim-fugitive",
	},
	-- fs tooling (rename buffer and file)
	{
		lazy = true,
		"tpope/vim-eunuch",
	},
	-- git gutter (diff in the sign column)
	{
		lazy = true,
		"airblade/vim-gitgutter",
	},
	-- ripgrep into quickfix (:Rg <string|pattern>)
	{
		lazy = true,
		"jremmen/vim-ripgrep",
	},
}
