return {
	{
		"sbdchd/neoformat",
		config = function()
			vim.cmd([[
				let g:neoformat_try_node_exe = 1
				let g:neoformat_enabled_css = ['prettier']
				augroup fmt
					autocmd!
					autocmd BufWritePre * Neoformat
				augroup END
			]])
		end,
	},
}
