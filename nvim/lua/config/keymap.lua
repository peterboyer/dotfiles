vim.g.mapleader = " "

-- consistent C-c/Esc behavour
vim.keymap.set("i", "<C-c>", "<Esc>")

-- fix gq to format correctly
vim.keymap.set("v", "gq", "gw")

-- fast system clipboard yank prefix
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')

-- cursor up/down 5 lines
vim.keymap.set("", "<C-j>", "5j")
vim.keymap.set("", "<C-k>", "5k")

-- faster e/y scroll
vim.keymap.set("n", "<C-e>", "5<C-e>")
vim.keymap.set("n", "<C-y>", "5<C-y>")

-- fast next modified buffer
vim.keymap.set("n", "<leader>m", "<cmd>:bmodified<cr>")

-- fast quickfix next/prev item
vim.keymap.set("n", "m", "<cmd>:cnext<cr>")
vim.keymap.set("n", "M", "<cmd>:cprev<cr>")

-- fast quickfix filter out test files
vim.cmd([[ packadd cfilter ]])
vim.keymap.set("n", "<leader>M", "<cmd>:Cfilter! \\.\\(test\\|spec\\)\\.<cr>")

-- visual move lines
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv")

-- substitute current word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- make current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<cr>")

-- yank current filepath to clipboard
vim.keymap.set("n", "<leader>^", '<cmd>:let @+ = expand("%")<cr>')

-- toggle spellcheck
vim.keymap.set("n", "gc", function()
	vim.o.spell = not vim.o.spell
end)
