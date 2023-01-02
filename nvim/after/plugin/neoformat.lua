vim.cmd [[
	let g:neoformat_try_node_exe = 1

	augroup fmt
		autocmd!
		autocmd BufWritePre * Neoformat
	augroup END
]]
