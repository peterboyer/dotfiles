local keys = {
	{ "<leader>c<leader>", ":<Plug>NERDCommenterToggle", silent = true, desc = "NerdCommenter Toggle" },
}

--
vim.g.NERDCreateDefaultMappings = 0
vim.g.NERDSpaceDelims = 1
vim.g.NERDDefaultAlign = "left"
--

return {
	{
		"preservim/nerdcommenter",
		keys = keys,
	},
}
