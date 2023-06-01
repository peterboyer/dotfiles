local keymap = function()
	local illuminate = require("illuminate")
	vim.keymap.set("n", "gn", illuminate.goto_next_reference)
	vim.keymap.set("n", "gN", illuminate.goto_prev_reference)
end

return {
	{
		"RRethy/vim-illuminate",
		config = function()
			keymap()
		end,
	},
}
