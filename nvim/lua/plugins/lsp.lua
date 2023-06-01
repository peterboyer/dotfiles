local config = function()
	-- completion
	local cmp = require("cmp")
	local lspkind = require("lspkind")
	-- https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#basic-customisations
	cmp.setup({
		completion = {
			-- autoselect the first item
			-- https://github.com/hrsh7th/nvim-cmp/issues/209#issuecomment-921635222
			completeopt = "menu,menuone,noinsert",
		},
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "path" },
			{ name = "buffer", keyword_length = 3 },
		}),
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered({
				{ max_height = 15, max_width = 60 },
			}),
		},
		formatting = {
			-- fancy icons
			-- https://github.com/onsails/lspkind.nvim
			format = lspkind.cmp_format({
				-- completion source
				-- https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#basic-customisations
				menu = {
					nvim_lsp = "[LSP]",
					path = "[Path]",
					buffer = "[Buffer]",
				},
			}),
		},
		mapping = cmp.mapping.preset.insert({
			-- https://github.com/VonHeikemen/lsp-zero.nvim/blob/9c9201eb3a3aace6746e3b85ca38adb4f73d4857/lua/lsp-zero/cmp.lua#LL210C11-L210C11
			["<C-d>"] = cmp.mapping.scroll_docs(4),
			["<C-u>"] = cmp.mapping.scroll_docs(-4),
			["<C-n>"] = cmp.mapping.confirm({ select = true }),
			["<C-h>"] = cmp.mapping.abort(),
			["<C-j>"] = cmp.mapping(function()
				if cmp.visible() then
					cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
				else
					cmp.complete()
				end
			end),
			["<C-k>"] = cmp.mapping(function()
				if cmp.visible() then
					cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
				else
					cmp.complete()
				end
			end),
		}),
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
	})

	require("mason").setup({
		ui = {
			border = "rounded",
		},
	})

	require("mason-lspconfig").setup({ automatic_installation = true })
	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	local setup_opts = { capabilities = capabilities }
	require("lspconfig").lua_ls.setup(setup_opts)
	require("lspconfig").tsserver.setup(setup_opts)
	require("lspconfig").jsonls.setup(setup_opts)
	require("lspconfig").html.setup(setup_opts)
	require("lspconfig").tailwindcss.setup(setup_opts)
	require("lspconfig").marksman.setup(setup_opts)
	require("lspconfig").bashls.setup(setup_opts)
	require("lspconfig").yamlls.setup(setup_opts)
	require("lspconfig").dockerls.setup(setup_opts)
	require("lspconfig").docker_compose_language_service.setup(setup_opts)

	require("mason-null-ls").setup({ automatic_installation = true })
	local null_ls = require("null-ls")
	null_ls.setup({
		sources = {
			null_ls.builtins.diagnostics.eslint_d,
			require("typescript.extensions.null-ls.code-actions"),
			null_ls.builtins.formatting.stylua,
			-- null_ls.builtins.completion.spell,
		},
	})

	-- addons
	require("inc_rename").setup()
	local inc_rename = function()
		return ":IncRename " .. vim.fn.expand("<cword>")
	end
	require("typescript").setup({
		go_to_source_definition = { fallback = true },
	})

	-- borders
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
	vim.lsp.handlers["textDocument/signatureHelp"] =
		vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
	vim.diagnostic.config({ float = { border = "rounded" } })

	-- lsp
	vim.keymap.set("n", "gl", vim.diagnostic.open_float)
	vim.keymap.set("n", "gq", vim.diagnostic.setloclist)
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_prev()
		vim.cmd('execute "normal zz"')
	end)
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_next()
		vim.cmd('execute "normal zz"')
	end)
	vim.keymap.set("n", "<leader>rn", function()
		print(":IncRename [lsp not ready]")
	end, { expr = true })

	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("UserLspConfig", {}),
		callback = function(ev)
			-- enable completion triggered by <c-x><c-o>
			vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

			local opts = { buffer = ev.buf }
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
			vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
			vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
			vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
			vim.keymap.set("n", "<leader>rn", inc_rename, { expr = true })
			-- vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
			vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
			vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
			vim.keymap.set("n", "<leader>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, opts)
			vim.keymap.set("n", "<leader>F", function()
				vim.lsp.buf.format({ async = true })
			end, opts)
		end,
	})
end

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"smjonas/inc-rename.nvim",
			"jose-elias-alvarez/typescript.nvim",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
			"onsails/lspkind.nvim",
			"jose-elias-alvarez/null-ls.nvim",
			"nvim-lua/plenary.nvim",
			"williamboman/mason.nvim",
			"jay-babu/mason-null-ls.nvim",
		},
		config = config,
	},
	{
		"j-hui/fidget.nvim",
		lazy = true,
		config = function()
			require("fidget").setup()
		end,
	},
	{
		"folke/trouble.nvim",
		enabled = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("trouble").setup()
		end,
	},
}
