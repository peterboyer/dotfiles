vim.cmd("colorscheme mono")

vim.o.mouse = false
-- vim.o.ttymouse = false

vim.o.wrap = false
vim.o.autoread = true

vim.o.cursorline = true
vim.o.number = true
vim.o.relativenumber = true

vim.cmd("autocmd TermOpen * setlocal nonu nornu")

-- hide/show line numbers on blur/focus
vim.cmd([[
	autocmd WinEnter * setlocal nu rnu
	autocmd WinLeave * setlocal nonu nornu
]])

-- tabs
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

-- search
vim.o.ignorecase = true

-- autocomplete
vim.o.wildmode = "longest,list"

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

