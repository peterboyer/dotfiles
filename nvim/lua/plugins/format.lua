return {
	{
		"sbdchd/neoformat",
		dependencies = {
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			vim.cmd([[
				let g:neoformat_try_node_exe = 1
				let g:neoformat_enabled_css = ['prettier']
				augroup fmt
					autocmd!
					autocmd BufWritePre * Neoformat
				augroup END
			]])

			require("mason-tool-installer").setup({
				ensure_installed = {
					"stylua",
					-- workaround for broken eslint-lsp after 4.8.0.
					-- https://github.com/neovim/nvim-lspconfig/issues/3149#issuecomment-2174945341
					{ "eslint-lsp", version = "4.8.0" },
				},
			})
		end,
	},
}
