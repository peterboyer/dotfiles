local keys = {
	{ "<leader>q", ":call ToggleQuickfixList()<cr>", silent = true, desc = "Quickfix Toggle" },
}

--
vim.g.toggle_list_no_mappings = true
--

return {
	{
		"milkypostman/vim-togglelist",
		keys = keys,
	},
}
