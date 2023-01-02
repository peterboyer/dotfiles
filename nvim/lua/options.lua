vim.cmd("colorscheme mono")
vim.o.termguicolors = false

vim.o.mouse = false
vim.o.guicursor = ""
vim.o.cursorline = true

vim.o.number = true
vim.o.relativenumber = true
-- auto hide/show line numbers on blur/focus
vim.cmd([[
	autocmd WinEnter * setlocal nu rnu
	autocmd WinLeave * setlocal nonu nornu
]])
-- auto hide line numbers for terminals
vim.cmd("autocmd TermOpen * setlocal nonu nornu")

-- textwrap
vim.o.wrap = false
vim.o.autoread = true

-- tabs
vim.o.tabstop = 4
vim.o.shiftwidth = 0

-- search
vim.o.ignorecase = true

-- autocomplete
-- vim.o.wildmode = "longest,list"

-- windows
vim.o.splitright = true
vim.o.splitbelow = true

-- folding
-- vim.o.foldenable = true
-- vim.o.foldmethod = "syntax"
-- vim.o.foldlevelstart = 99

-- whitespace
vim.o.list = true
vim.o.listchars = table.concat({
	"extends:»",
	"tab:┄┄",
	"trail:∙",
	-- "eol:↵",
}, ",")

