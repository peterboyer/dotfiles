vim.g.mapleader = " "

-- cursor up/down 5 lines
vim.keymap.set("", "<C-j>", "5j")
vim.keymap.set("", "<C-k>", "5k")

-- faster e/y scroll
vim.keymap.set("n", "<C-e>", "5<C-e>")
vim.keymap.set("n", "<C-y>", "5<C-y>")

-- visual move lines
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv", { desc = "Visual Move Lines Up" })
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv", { desc = "Visual Move Lines Down" })

-- substitute current word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace Word" })

-- yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to Clipboard" })

-- yank current filepath to clipboard
vim.keymap.set("n", "<leader>^", '<cmd>:let @+ = expand("%")<cr>', { desc = "Yank Buffer Filepath to Clipboard" })

-- next modified buffer
vim.keymap.set("n", "<leader>m", "<cmd>:bmodified<cr>", { desc = "Buffer Next Modified" })

-- quickfix next/prev item
vim.keymap.set("n", "m", "<cmd>:cnext<cr>", { desc = "Quickfix Next" })
vim.keymap.set("n", "M", "<cmd>:cprev<cr>", { desc = "Quickfix Prev" })

-- quickfix filter out test files
vim.cmd([[ packadd cfilter ]])
vim.keymap.set(
	"n",
	"<leader>M",
	"<cmd>:Cfilter! \\.\\(test\\|spec\\)\\.<cr>",
	{ desc = "Quickfix Filter Test/Spec Files" }
)

-- make current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<cr>", { desc = "Chmod Buffer File as Executable" })

-- toggle spellcheck
vim.keymap.del("n", "gc")
vim.keymap.del("n", "gcc")
vim.keymap.set("n", "gc", function()
	vim.o.spell = not vim.o.spell
end, { desc = "Spellcheck Toggle" })

-- @workaround
-- consistent C-c/Esc behavour
vim.keymap.set("i", "<C-c>", "<Esc>")

-- @workaround
-- fix gq to format correctly
vim.keymap.set("v", "gq", "gw")

-- @workaround
-- search word under cursor without moving
vim.keymap.set("n", "*", [[:let @/ = "\\<<C-r><C-w>\\>"<cr>:set hlsearch<cr>]])
