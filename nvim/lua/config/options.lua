vim.cmd("colorscheme mono")

vim.o.mouse = false
vim.o.guicursor = ""
vim.o.cursorline = true
vim.o.colorcolumn = "80"

vim.o.signcolumn = "yes"
vim.o.number = true
vim.o.relativenumber = false

-- terminal
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

-- statusline
-- https://shapeshed.com/vim-statuslines/
-- https://www.reddit.com/r/neovim/comments/tz6p7i/how_can_we_set_color_for_each_part_of_statusline/
vim.o.statusline = table.concat({ "▲ %F %#BufferAttribute#%m%*", "%=", "%l:%c (%p%%)" }, "")

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

-- :W "noautocmd write" shortcut
vim.cmd([[
function! W()
	noautocmd write
endfunction
command! W call W()
]])

-- chat
vim.cmd([[
function! Chat(message)
	silent execute "!curl --silent http://localhost:4111/chat --data" "\"" escape(a:message, '!"') "\""
	echo ""
endfunction
command! -nargs=+ Chat call Chat(<q-args>)
]])
