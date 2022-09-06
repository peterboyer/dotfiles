-- custom colorscheme
vim.cmd("colorscheme mono")

-- highlight current line
vim.o.cursorline = true
-- enable line numbers
vim.o.number = true
-- enable relative line numbers
vim.o.relativenumber = true

vim.cmd([[
  autocmd WinEnter * setlocal nu rnu
  autocmd WinLeave * setlocal nonu nornu
]])

-- disable line numbers for terminals
vim.cmd("autocmd TermOpen * setlocal nonu nornu")

-- number of columns for a tab
vim.o.tabstop = 2
-- number of columns for a tab when editing
vim.o.softtabstop = 2
-- number of spaces to use for indentation
vim.o.shiftwidth = 2
-- <Tab> inserts spaces instead of real tabs
vim.o.expandtab = true

-- ignore case of search expr
vim.o.ignorecase = true
-- use bash-like tab completions
vim.o.wildmode = "longest,list"

vim.o.splitright = true
vim.o.splitbelow = true

-- autoread
vim.o.autoread = true

-- folding
vim.o.foldenable = true
vim.o.foldmethod = "syntax"
vim.o.foldlevelstart = 99

-- comfy vertical viewport
vim.o.scrolloff = 7

-- disable word wrap
vim.o.wrap = false
-- vim.o.sidescroll = 50

-- visible control characters
vim.o.list = true
vim.o.listchars = table.concat({
  -- char in last column for line beyond screen width
  "extends:»",
  -- char to represent tabs
  "tab:»·",
  -- char to represent trailing spaces
  "trail:·",
  -- char to show end of line chars
  -- "eol:~",
}, ",")

