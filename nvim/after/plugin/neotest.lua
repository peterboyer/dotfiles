-- https://github.com/JoosepAlviste/dotfiles/blob/master/config/nvim/lua/j/plugins/neotest.lua

require("neotest").setup({
	adapters = {
		require("neotest-jest")({
			jestCommand = "npm run test",
		}),
	},
	diagnostic = {
		enabled = true,
	},
})

local neotest = require("neotest").run
local summary = require("neotest").summary

-- [t]est
-- > [r]un
vim.keymap.set("n", "<leader>tr", function() print("neotest: run"); neotest.run() end)
-- > [R] stop
vim.keymap.set("n", "<leader>tR", function() print("neotest: stop"); neotest.stop() end)
-- > [d]ebug
vim.keymap.set("n", "<leader>td", function() print("neotest: debug"); neotest.run({ strategy = "dap" }) end)
-- > [f]ile
vim.keymap.set("n", "<leader>tf", function() print("neotest: file"); neotest.run(vim.fn.expand("%")) end)
-- > [l]ast ran
vim.keymap.set("n", "<leader>tl", function() print("neotest: last"); neotest.run_last() end)
-- > [s]ummary
vim.keymap.set("n", "<leader>ts", function() summary.toggle() end)
