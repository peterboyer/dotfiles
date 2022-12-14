local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.set_preferences {
	sign_icons = {
		error = "E",
		warn = "W",
		hint = "H",
		info = "I",
	}
}

lsp.ensure_installed {
	"eslint",
	"tsserver",
	"rust_analyzer",
	"sumneko_lua",
	"vimls",
	"yamlls",
	"bashls",
	"jsonls",
}

local cmp = require("cmp")
local select_opts = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings {
	["<C-n>"] = cmp.mapping.confirm(),
	["<C-j>"] = cmp.mapping.select_next_item(select_opts),
	["<C-k>"] = cmp.mapping.select_prev_item(select_opts),
}

cmp_mappings["<CR>"] = nil
cmp_mappings["<Tab>"] = nil
cmp_mappings["<S-Tab>"] = nil

lsp.setup_nvim_cmp {
	mapping = cmp_mappings,
}

lsp.on_attach(function(_, buffer)
	local opts = { buffer = buffer, silent = true }
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
end)

lsp.setup()

vim.keymap.set("n", "[d", function()
	vim.diagnostic.goto_prev()
	vim.cmd("execute \"normal zz\"")
end)
vim.keymap.set("n", "]d", function()
	vim.diagnostic.goto_next()
	vim.cmd("execute \"normal zz\"")
end)
