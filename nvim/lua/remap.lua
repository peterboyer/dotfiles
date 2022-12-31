vim.g.mapleader = " "

-- faster e/y scroll
vim.keymap.set("n", "<C-e>", function ()
	vim.exec("5<C-e>")
end)
vim.keymap.set("n", "<C-y>", '5<C-y>')

-- centered cursor on scroll
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- centered cursor on search
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- reference
-- zc (close fold) zC (close ALL fold levels)
-- zo (open fold) zO (open ALL fold levels)
-- za (toggle fold) zA (toggle ALL fold levels)
-- zr (reduce folding, OPEN over whole buffer), zR (reduce ALL folding, to top)
-- zm (maximise folding, CLOSE over whole buffer), zM (maximise ALL folding, to top)

-- cursor up/down 5 lines
vim.keymap.set("", "<C-j>", "5j")
vim.keymap.set("", "<C-k>", "5k")
-- scroll up/down 5 lines
vim.keymap.set("n", "<A-j>", "5<C-e>", { remap = true })
vim.keymap.set("n", "<A-k>", "5<C-y>", { remap = true })
-- [macOS]
vim.keymap.set("n", "∆", "<A-j>", { remap = true })
vim.keymap.set("n", "˚", "<A-k>", { remap = true })

-- detab
-- C-t (tab) shift right | or <Tab>
-- C-d (de-tab) shift left | or <S-Tab>
vim.keymap.set("i", "<S-Tab>", "<C-d>", { remap = true })

-- move line (insert)
-- vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<cr>==gi")
-- vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<cr>==gi")
-- move lines (visual)
-- vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv")
-- vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv")

-- destroy buffer (preserve window layout)
-- (q)uit
vim.keymap.set("n", "<C-w>q", "<cmd>:Bdelete<cr>")
vim.keymap.set("n", "<C-w><C-q>", "<cmd>:bdelete<cr>")

-- (e)xplore
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

-- telescope
-- o(p)en | (b)uffers | (f)ind -> (g)rep | (h)elp-tags | git (s)tatus
vim.keymap.set("n", "<leader>p", function() require("telescope.builtin").find_files() end)
vim.keymap.set("n", "<leader>P", function() require("telescope.builtin").oldfiles() end)
vim.keymap.set("n", "<leader>b", function() require("telescope.builtin").buffers() end)
vim.keymap.set("n", "<leader>fg", function() require("telescope.builtin").live_grep() end)
vim.keymap.set("n", "<leader>fh", function() require("telescope.builtin").help_tags() end)
vim.keymap.set("n", "<leader>fs", function() require("telescope.builtin").git_status() end)

-- lsp
vim.keymap.set("n", "[d", function()
	vim.diagnostic.goto_prev()
	vim.cmd("execute \"normal zz\"")
end)
vim.keymap.set("n", "]d", function()
	vim.diagnostic.goto_next()
	vim.cmd("execute \"normal zz\"")
end)

vim.keymap.set("n", "<leader>k", function() vim.diagnostic.open_float() end)
vim.keymap.set("n", "<leader>q", function() vim.diagnostic.setloclist() end)

lsp_on_attach = function(_, buffer)
	vim.api.nvim_buf_set_option(buffer, "omnifunc", "v:lua.vim.lsp.omnifunc")

	local opts = { buffer = buffer }
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
	vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
	vim.keymap.set("n", "<leader>D", function() vim.lsp.buf.type_definition() end, opts)
	vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.formatting() end, opts)
	vim.keymap.set("n", "<leader>wa", function() vim.lsp.buf.add_workspace_folder() end, opts)
	vim.keymap.set("n", "<leader>wr", function() vim.lsp.buf.remove_workspace_folder() end, opts)
	vim.keymap.set("n", "<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
	vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
end

-- debugger
-- J (over v) | L (in >) | K (out ^) | H (< continue)
vim.keymap.set("n", "<S-C-h>", function() require"dap".continue() end)
vim.keymap.set("n", "<S-C-j>", function() require"dap".step_over() end)
vim.keymap.set("n", "<S-C-l>", function() require"dap".step_into() end)
vim.keymap.set("n", "<S-C-k>", function() require"dap".step_out() end)
-- (d)ebugger -> (b)reakpoint | (B)reakpoint condition | (q)uit | (r)epl | (i)nteractive | (?) verbose
vim.keymap.set("n", "<leader>db", function() require"dap".toggle_breakpoint() end)
vim.keymap.set("n", "<leader>dB", function() require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: ")) end)
vim.keymap.set("n", "<leader>dq", function() require"dap".terminate() end)
vim.keymap.set("n", "<leader>dr", function() require"dap".repl.open() end)
vim.keymap.set("n", "<leader>dl", function() require"dap".run_last() end)
vim.keymap.set("n", "<leader>di", function() require"dap.ui.widgets".hover() end)
vim.keymap.set("n", "<leader>d?", function() local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes) end)

-- jester
-- (t)est -> (t)est | (f)ile | (l)ast | [(d)ebug -> (t)est | (f)ile | (l)ast]
vim.keymap.set("n", "<leader>tt", function() require"jester".run() end)
vim.keymap.set("n", "<leader>tf", function() require"jester".run_file() end)
vim.keymap.set("n", "<leader>tl", function() require"jester".run_last() end)
vim.keymap.set("n", "<leader>tdt", function() require"jester".debug() end)
vim.keymap.set("n", "<leader>tdf", function() require"jester".debug_file() end)
vim.keymap.set("n", "<leader>tdl", function() require"jester".debug_last() end)

