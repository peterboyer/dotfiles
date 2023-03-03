require("typescript").setup({
	go_to_source_definition = {
		 -- fall back to standard LSP definition on failure
		fallback = true,
	},
})
