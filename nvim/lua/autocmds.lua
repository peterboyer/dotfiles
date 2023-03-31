-- hide line numbers for terminal windows
vim.cmd("autocmd TermOpen * setlocal nonu nornu")

-- open netrw by default if no current file
vim.cmd[[
	augroup InitNetrw
		autocmd!
		autocmd VimEnter * if expand("%") == "" | edit . | endif
	augroup END
]]
