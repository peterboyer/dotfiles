vim.cmd("colorscheme mono")
vim.o.termguicolors = false

vim.o.mouse = false
vim.o.guicursor = ""
vim.o.cursorline = true
vim.o.colorcolumn = "80"

vim.o.signcolumn = "yes"
vim.o.number = true
vim.o.relativenumber = true
vim.cmd("autocmd TermOpen * setlocal nonu nornu")

-- wrap
vim.o.wrap = false
vim.o.autoread = true

-- spell
vim.o.spell = false

-- scroll
vim.o.scrolloff = 8

-- tabs
vim.o.tabstop = 2
vim.o.shiftwidth = 0

-- tabs/spaces switcher
vim.cmd([[
function! Tabs(width=2)
	set noexpandtab | let &tabstop=a:width | set shiftwidth=0
endfunction
command! -nargs=* Tabs call Tabs(<f-args>)
function! Spaces(width=2)
	set expandtab | let &tabstop=a:width | set shiftwidth=0
endfunction
command! -nargs=* Spaces call Spaces(<f-args>)
]])

-- search
vim.o.ignorecase = true

-- windows
vim.o.splitright = true
vim.o.splitbelow = true

-- folding
vim.o.foldenable = true
vim.o.foldmethod = "indent"
vim.o.foldlevelstart = 99

-- whitespace
vim.o.list = true
vim.o.listchars = table.concat({
	"extends:»",
	"tab:┄┄",
	"trail:∙",
	-- "eol:↵",
}, ",")

-- quickfix plugins
vim.cmd([[ packadd cfilter ]])
