local keymap = function()
	vim.keymap.set("n", "<leader>e", vim.cmd.NvimTreeFindFile)
	vim.keymap.set("n", "<leader>E", vim.cmd.NvimTreeToggle)
end

return {
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("nvim-tree").setup({
				hijack_netrw = false,
				sort_by = "case_sensitive",
				on_attach = function(buffer)
					local api = require("nvim-tree.api")
					local function opts(desc)
						return {
							desc = "nvim-tree: " .. desc,
							buffer = buffer,
							noremap = true,
							silent = true,
							nowait = true,
						}
					end
					api.config.mappings.default_on_attach(buffer)
					vim.keymap.del("n", "<C-k>", { buffer = buffer })
					vim.keymap.set("n", "K", api.node.show_info_popup, opts("Info"))
				end,
				view = {
					width = 30,
				},
				renderer = {
					group_empty = true,
				},
			})
			keymap()

			-- auto_close if last buffer
			-- https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close#ppwwyyxx
		end,
	},
}
