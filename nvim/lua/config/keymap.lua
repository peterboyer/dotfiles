vim.g.mapleader = " "

-- consistent C-c/Esc behavour
vim.keymap.set("i", "<C-c>", "<Esc>")

-- prompt new file in same dir as current buffer
vim.keymap.set("n", "<leader>%", ":e %:h/")

-- fix gq to format correctly
vim.keymap.set("v", "gq", "gw")

-- close all buffers
vim.keymap.set("n", "<leader>Q", ":%bd<CR>")

-- cursor up/down 5 lines
vim.keymap.set("", "<C-j>", "5j")
vim.keymap.set("", "<C-k>", "5k")

-- faster e/y scroll
vim.keymap.set("n", "<C-e>", "5<C-e>")
vim.keymap.set("n", "<C-y>", "5<C-y>")

-- centered cursor on search
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- visual move lines
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv")

-- fast system clipboard yank prefix
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')

-- substitute current word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- make current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>")

-- quickfix next/prev + centered
vim.keymap.set("n", "<A-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<A-k>", "<cmd>cprev<CR>zz")

-- fast quickfix next/prev item
vim.keymap.set("n", "m", "<cmd>:cnext<cr>")
vim.keymap.set("n", "M", "<cmd>:cprev<cr>")

-- toggle spellcheck
vim.keymap.set("n", "gc", function()
	vim.o.spell = not vim.o.spell
end)
