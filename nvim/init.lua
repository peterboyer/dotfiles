require("plugins")
require("options")

function map(mode, shortcut, command, opts)
  opts = opts or {}
  vim.keymap.set(mode, shortcut, command, {
    silent = true,
    buffer = opts.buffer,
    remap = opts.recursive,
  })
end

-- leader space
vim.g.mapleader = " "

-- reference
-- zc (close fold) zC (close ALL fold levels)
-- zo (open fold) zO (open ALL fold levels)
-- za (toggle fold) zA (toggle ALL fold levels)
-- zr (reduce folding, OPEN over whole buffer), zR (reduce ALL folding, to top)
-- zm (maximise folding, CLOSE over whole buffer), zM (maximise ALL folding, to top)

-- cursor up/down 5 lines
map("", "<C-j>", "5j")
map("", "<C-k>", "5k")
-- scroll up/down 5 lines
map("n", "<A-j>", "5<C-e>", { recursive = true })
map("n", "<A-k>", "5<C-y>", { recursive = true })
-- [macOS]
map("n", "∆", "<A-j>", { recursive = true })
map("n", "˚", "<A-k>", { recursive = true })

-- move line (insert)
-- map("i", "<A-j>", "<Esc>:m .+1<cr>==gi")
-- map("i", "<A-k>", "<Esc>:m .-2<cr>==gi")
-- move lines (visual)
-- map("v", "<A-j>", ":m '>+1<cr>gv=gv")
-- map("v", "<A-k>", ":m '<-2<cr>gv=gv")

-- [<n] prev [m>] next buffer
map("n", "<leader>n", ":bp<cr>")
map("n", "<leader>m", ":bn<cr>")

-- switch buffer
-- (g)o to alt buffer
-- map("n", "<leader>g", "<C-6>", { recursive = true })

-- destroy buffer (preserve window layout)
-- (q)uit
map("n", "<C-w>q", "<cmd>:Bdelete<cr>")

-- select (a)ll
-- map("n", "<C-a>", "gg<S-v>G")

-- (d)elete without yank
-- map("n", "<leader>d", "\"_d")
-- map("n", "<leader>s", "\"_s")
-- map("n", "<leader>x", "\"_x")

-- lf
-- (e)xplore
map("n", "<leader>e", "<cmd>Lf<cr>")

-- telescope
-- o(p)en | (b)uffers | (f)ind -> (g)rep | (h)elp-tags
map("n", "<leader>p", function() require("telescope.builtin").find_files() end)
map("n", "<leader>b", function() require("telescope.builtin").buffers() end)
map("n", "<leader>fg", function() require("telescope.builtin").live_grep() end)
map("n", "<leader>fh", function() require("telescope.builtin").help_tags() end)

-- lsp
map("n", "[d", function() vim.diagnostic.goto_prev() end)
map("n", "]d", function() vim.diagnostic.goto_next() end)
map("n", "<leader>k", function() vim.diagnostic.open_float() end)
-- map("n", "<leader>q", function() vim.diagnostic.setloclist() end)

lsp_on_attach = function(_client, buffer)
  vim.api.nvim_buf_set_option(buffer, "omnifunc", "v:lua.vim.lsp.omnifunc")

  local opts = { buffer = buffer }
  map("n", "K", function() vim.lsp.buf.hover() end, opts)
  map("n", "gD", function() vim.lsp.buf.declaration() end, opts)
  map("n", "gd", function() vim.lsp.buf.definition() end, opts)
  map("n", "gi", function() vim.lsp.buf.implementation() end, opts)
  map("n", "gr", function() vim.lsp.buf.references() end, opts)
  map("n", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
  map("n", "<leader>D", function() vim.lsp.buf.type_definition() end, opts)
  map("n", "<leader>f", function() vim.lsp.buf.formatting() end, opts)
  map("n", "<leader>wa", function() vim.lsp.buf.add_workspace_folder() end, opts)
  map("n", "<leader>wr", function() vim.lsp.buf.remove_workspace_folder() end, opts)
  map("n", "<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
  map("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
  map("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
end

-- debugger
-- J (over v) | L (in >) | K (out ^) | H (< continue)
map("n", "<S-C-h>", function() require"dap".continue() end)
map("n", "<S-C-j>", function() require"dap".step_over() end)
map("n", "<S-C-l>", function() require"dap".step_into() end)
map("n", "<S-C-k>", function() require"dap".step_out() end)
-- (d)ebugger -> (b)reakpoint | (B)reakpoint condition | (q)uit | (r)epl | (i)nteractive | (?) verbose
map("n", "<leader>db", function() require"dap".toggle_breakpoint() end)
map("n", "<leader>dB", function() require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: ")) end)
map("n", "<leader>dq", function() require"dap".terminate() end)
map("n", "<leader>dr", function() require"dap".repl.open() end)
map("n", "<leader>dl", function() require"dap".run_last() end)
map("n", "<leader>di", function() require"dap.ui.widgets".hover() end)
map("n", "<leader>d?", function() local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes) end)

-- jester
-- (t)est -> (t)est | (f)ile | (l)ast | [(d)ebug -> (t)est | (f)ile | (l)ast]
map("n", "<leader>tt", function() require"jester".run() end)
map("n", "<leader>tf", function() require"jester".run_file() end)
map("n", "<leader>tl", function() require"jester".run_last() end)
map("n", "<leader>tdt", function() require"jester".debug() end)
map("n", "<leader>tdf", function() require"jester".debug_file() end)
map("n", "<leader>tdl", function() require"jester".debug_last() end)

