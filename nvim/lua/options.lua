vim.cmd("colorscheme mono")
vim.o.termguicolors = false

vim.o.mouse = false
vim.o.guicursor = ""
vim.o.cursorline = true
vim.o.colorcolumn = "80"

vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.cmd("autocmd TermOpen * setlocal nonu nornu")

-- wrap
vim.o.wrap = false
vim.o.autoread = true

-- scroll
vim.o.scrolloff = 8

-- tabs
vim.o.tabstop = 4
vim.o.shiftwidth = 0

-- search
vim.o.ignorecase = true

-- windows
vim.o.splitright = true
vim.o.splitbelow = true

-- folding
vim.o.foldenable = true
vim.o.foldmethod = "syntax"
vim.o.foldlevelstart = 99

-- whitespace
vim.o.list = true
vim.o.listchars = table.concat({
	"extends:»",
	"tab:┄┄",
	"trail:∙",
	-- "eol:↵",
}, ",")

-- auto-netrw
vim.cmd[[
	augroup InitNetrw
		autocmd!
		autocmd VimEnter * if expand("%") == "" | edit . | endif
	augroup END
]]
