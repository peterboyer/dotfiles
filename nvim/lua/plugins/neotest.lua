local keymap = function()
	-- [t]est
	-- > [r]un
	vim.keymap.set("n", "<leader>tr", function()
		print("neotest: run")
		require("neotest").run.run()
	end)
	-- > [R] stop
	vim.keymap.set("n", "<leader>tR", function()
		print("neotest: stop")
		require("neotest").run.stop()
	end)
	-- > [d]ebug
	vim.keymap.set("n", "<leader>td", function()
		print("neotest: debug")
		require("neotest").run.run({ strategy = "dap" })
	end)
	-- > [f]ile
	vim.keymap.set("n", "<leader>tf", function()
		print("neotest: file")
		require("neotest").run.run(vim.fn.expand("%"))
	end)
	-- > [l]ast ran
	vim.keymap.set("n", "<leader>tl", function()
		print("neotest: last")
		require("neotest").run.run_last()
	end)
	-- > [s]ummary
	vim.keymap.set("n", "<leader>ts", function()
		require("neotest").summary.toggle()
	end)
end

local config = function()
	-- https://github.com/JoosepAlviste/dotfiles/blob/master/config/nvim/lua/j/plugins/neotest.lua
	require("neotest").setup({
		adapters = {
			require("neotest-jest")({
				jestCommand = "npm test --",
				env = { CI = true },
			}),
		},
		diagnostic = {
			enabled = true,
		},
	})
	keymap()
end

return {
	{
		enabled = false,
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"haydenmeade/neotest-jest",
		},
		config = config,
	},
}
