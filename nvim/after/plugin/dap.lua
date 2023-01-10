-- https://github.com/anasrar/.dotfiles/tree/2023/neovim/.config/nvim/lua/rin/DAP

require("mason-tool-installer").setup({
	ensure_installed = {
		"js-debug-adapter",
	}
})

require("dap-vscode-js").setup({
	node_path = "node",
	debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",
	adapters = {
		"pwa-node",
		"pwa-chrome",
		"pwa-msedge",
		"node-terminal",
		"pwa-extensionHost",
	},
})

local languages = {
	"javascript",
	"typescript",
	"javascriptreact",
	"typescriptreact",
}

for _, language in ipairs(languages) do
	require("dap").configurations[language] = {
		-- https://github.com/mxsdev/nvim-dap-vscode-js#nodejs
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = "${workspaceFolder}",
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach",
			processId = require("dap.utils").pick_process,
			cwd = "${workspaceFolder}",
		},
		-- https://github.com/mxsdev/nvim-dap-vscode-js#jest2
		{
			type = "pwa-node",
			request = "launch",
			name = "Debug Jest Tests",
			runtimeExecutable = "node",
			runtimeArgs = {
				"./node_modules/jest/bin/jest.js",
				"--runInBand",
			},
			rootPath = "${workspaceFolder}",
			cwd = "${workspaceFolder}",
			console = "integratedTerminal",
			internalConsoleOptions = "neverOpen",
		}
	}
end

require("dap.ext.vscode").load_launchjs(nil, {
  ["python"] = {
    "python",
  },
  ["pwa-node"] = {
    "javascript",
    "typescript",
  },
  ["node"] = {
    "javascript",
    "typescript",
  },
  ["cppdbg"] = {
    "c",
    "cpp",
  },
  ["dlv"] = {
    "go",
  },
})

local dap = require("dap")
local widgets = require("dap.ui.widgets")

-- [p]eak at value
vim.keymap.set("n", "<C-p>", widgets.hover)

-- close widgets.hover with C-c or q
-- https://github.com/mfussenegger/nvim-dap/issues/415#issuecomment-1017180055
vim.cmd[[
	augroup dap_float
		autocmd!
		autocmd FileType dap-float nnoremap <buffer><silent> q <cmd>close!<CR>
		autocmd FileType dap-float nnoremap <buffer><silent> <C-c> <cmd>close!<CR>
		" prevent nested hover instances
		autocmd FileType dap-float nnoremap <buffer><silent> <C-p> <nop>
	augroup end
]]

-- [d]ebug
-- > [b]reakpoint
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
-- > [B]reakpoint with condition
vim.keymap.set("n", "<leader>dB", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end)
-- > log[p]oint with message
vim.keymap.set("n", "<leader>dp", function() dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end)
-- > [s]tart
vim.keymap.set("n", "<leader>ds", dap.continue)
-- > [S]top
vim.keymap.set("n", "<leader>dS", dap.terminate)
-- > to [l]ocation
vim.keymap.set("n", "<leader>dl", dap.run_to_cursor)
-- > [n]ext
vim.keymap.set("n", "<leader>dn", dap.step_over)
-- > [N]ext into
vim.keymap.set("n", "<leader>dN", dap.step_into)
-- > [o]ut
vim.keymap.set("n", "<leader>do", dap.step_out)
-- > [r]epl toggle
vim.keymap.set("n", "<leader>dr", dap.repl.toggle)
