vim.g.mapleader = " "

-- consistent C-c/Esc behavour
vim.keymap.set("i", "<C-c>", "<Esc>")

-- (e)xplore
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
vim.keymap.set("n", "<leader>w", vim.cmd.Lf)

-- cursor up/down 5 lines
vim.keymap.set("", "<C-j>", "5j")
vim.keymap.set("", "<C-k>", "5k")

-- faster e/y scroll
vim.keymap.set("n", "<C-e>", "5<C-e>")
vim.keymap.set("n", "<C-y>", "5<C-y>")

-- faster e/y scroll with centered cursor
vim.keymap.set("n", "E", "5j5<C-e>")
vim.keymap.set("n", "Y", "5k5<C-y>")

-- centered cursor on scroll
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- centered cursor on search
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- visual move lines
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv")

-- fast system clipboard yank prefix
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")

-- substitute current word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- make current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>")

-- quickfix next/prev + centered
vim.keymap.set("n", "<A-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<A-k>", "<cmd>cprev<CR>zz")

-- destroy buffer (preserve window layout)
-- (q)uit
vim.keymap.set("n", "<C-w>q", "<cmd>:Bdelete<cr>")
vim.keymap.set("n", "<C-w><C-q>", "<cmd>:bdelete<cr>")

-- fast quickfix next/prev item
vim.keymap.set("n", "[q", "<cmd>:cprev<cr>")
vim.keymap.set("n", "]q", "<cmd>:cnext<cr>")
