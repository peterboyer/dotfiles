return {
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").set_default_icon("", "#ffffff", "NONE")
			require("nvim-web-devicons").setup({ color_icons = false })
		end,
	},
}
