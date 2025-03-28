local keys = {
	{ "<leader>Q", ":Bdelete menu<cr>", silent = true, desc = "Close Buffers" },
}

return {
	{
		"asheq/close-buffers.vim",
		keys = keys,
	},
}
