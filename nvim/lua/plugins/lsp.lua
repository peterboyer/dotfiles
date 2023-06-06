local keys = {
	buffer = function()
		local map = function(fn)
			return {
				{ "n", "K", vim.lsp.buf.hover },
				{ "n", "gd", vim.lsp.buf.definition },
				{ "n", "gD", vim.lsp.buf.declaration },
				{ "n", "gi", vim.lsp.buf.implementation },
				{ "n", "go", vim.lsp.buf.type_definition },
				{ "n", "gr", vim.lsp.buf.references },
				{ "n", "gs", vim.lsp.buf.signature_help },
				{ "n", "<leader>rn", fn.rename, { expr = true } },
				{ { "n", "v" }, "<leader>ca", vim.lsp.buf.code_action },
				{ "n", "<leader>wa", vim.lsp.buf.add_workspace_folder },
				{ "n", "<leader>wr", vim.lsp.buf.remove_workspace_folder },
				{ "n", "<leader>wl", fn.list_workspace_folders },
				{ "n", "<leader>F", fn.format },
				{ "n", "<leader>RN", ":TypescriptRenameFile<CR>" },
			}
		end
		return map({
			rename = function()
				return ":IncRename " .. vim.fn.expand("<cword>")
			end,
			list_workspace_folders = function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end,
			format = function()
				vim.lsp.buf.format({ async = true })
			end,
		})
	end,
	diagnostic = function()
		local map = function(fn)
			return {
				{ "n", "gl", vim.diagnostic.open_float },
				{ "n", "gL", fn.toggle },
				{ "n", "gQ", vim.diagnostic.setqflist },
				{ "n", "[d", fn.goto_prev },
				{ "n", "]d", fn.goto_next },
			}
		end
		return map({
			goto_prev = function()
				vim.diagnostic.goto_prev()
				vim.cmd('execute "normal zz"')
			end,
			goto_next = function()
				vim.diagnostic.goto_next()
				vim.cmd('execute "normal zz"')
			end,
			toggle = function()
				local current_buffer = 0
				if vim.diagnostic.is_disabled() then
					vim.diagnostic.enable(current_buffer)
				else
					vim.diagnostic.disable(current_buffer)
				end
			end,
		})
	end,
	complete = function(cmp)
		local map = function(fn)
			return {
				["<C-d>"] = cmp.mapping.scroll_docs(4),
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-n>"] = cmp.mapping.confirm({ select = true }),
				["<C-h>"] = cmp.mapping.abort(),
				["<C-j>"] = cmp.mapping(fn.next_item),
				["<C-k>"] = cmp.mapping(fn.prev_item),
			}
		end
		return map({
			next_item = function()
				if cmp.visible() then
					cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
				else
					cmp.complete()
				end
			end,
			prev_item = function()
				if cmp.visible() then
					cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
				else
					cmp.complete()
				end
			end,
		})
	end,
}

local config = function()
	local cmp = require("cmp")
	local lspkind = require("lspkind")
	local keys_complete = keys.complete(cmp)
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
					luasnip = "[Snippet]",
					path = "[Path]",
					buffer = "[Buffer]",
				},
			}),
		},
		mapping = cmp.mapping.preset.insert(keys_complete),
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
	})

	require("mason").setup({ ui = { border = "rounded" } })
	require("mason-lspconfig").setup({ automatic_installation = true })

	local lspconfig = require("lspconfig")
	local setup_opts = { capabilities = require("cmp_nvim_lsp").default_capabilities() }
	lspconfig.lua_ls.setup(setup_opts)
	lspconfig.eslint.setup(setup_opts)
	lspconfig.tsserver.setup(setup_opts)
	lspconfig.jsonls.setup(setup_opts)
	lspconfig.html.setup(setup_opts)
	lspconfig.tailwindcss.setup(setup_opts)
	lspconfig.marksman.setup(setup_opts)
	lspconfig.bashls.setup(setup_opts)
	lspconfig.yamlls.setup(setup_opts)
	lspconfig.dockerls.setup(setup_opts)
	lspconfig.docker_compose_language_service.setup(setup_opts)

	local null_ls = require("null-ls")
	null_ls.setup({
		sources = {
			null_ls.builtins.formatting.eslint_d,
			null_ls.builtins.formatting.stylua,
		},
	})
	require("mason-null-ls").setup({ automatic_installation = true })

	-- addons
	require("inc_rename").setup()
	require("typescript").setup({ go_to_source_definition = { fallback = true } })

	-- ui
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
	vim.lsp.handlers["textDocument/signatureHelp"] =
		vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
	vim.diagnostic.config({ float = { border = "rounded" } })

	-- lsp
	local keys_buffer = keys.buffer()
	local keys_diagnostic = keys.diagnostic()
	local keymap = function()
		for _, v in pairs(keys_diagnostic) do
			vim.keymap.set(v[1], v[2], v[3])
		end
		for _, v in pairs(keys_buffer) do
			vim.keymap.set(v[1], v[2], function()
				print("[" .. v[2] .. "] LSP: Not Attached")
			end)
		end
	end
	local keymap_on_buffer = function(buffer)
		for _, v in pairs(keys_buffer) do
			local opts = { buffer = buffer }
			local keyopts = v[4] or {}
			for K, V in pairs(keyopts) do
				opts[K] = V
			end
			vim.keymap.set(v[1], v[2], v[3], opts)
		end
		-- enable completion triggered by <c-x><c-o>
		vim.bo[buffer].omnifunc = "v:lua.vim.lsp.omnifunc"
	end

	keymap()
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("UserLspConfig", {}),
		callback = function(event)
			keymap_on_buffer(event.buf)
		end,
	})
end

return {
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			-- null-ls
			"jose-elias-alvarez/null-ls.nvim",
			"jay-babu/mason-null-ls.nvim",
			"nvim-lua/plenary.nvim",
			-- addons
			"smjonas/inc-rename.nvim",
			"jose-elias-alvarez/typescript.nvim",
			-- cmp
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
			"onsails/lspkind.nvim",
		},
		config = config,
	},
	{
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup()
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("trouble").setup()
		end,
	},
}
