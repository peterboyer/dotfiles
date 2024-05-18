local keys = {
	buffer = function()
		local map = function(fn)
			return {
				{ "n", "K", vim.lsp.buf.hover },
				{ "n", "gd", vim.lsp.buf.definition },
				{ "n", "gD", vim.lsp.buf.type_definition },
				{ "n", "gi", vim.lsp.buf.implementation },
				{ "n", "go", vim.lsp.buf.declaration },
				{ "n", "gr", vim.lsp.buf.references },
				{ "n", "gs", vim.lsp.buf.signature_help },
				{ "n", "gn", fn.goto_next_reference },
				{ "n", "gN", fn.goto_prev_reference },
				{ "n", "gf", fn.format },
				{ "n", "<leader>rn", fn.rename, { expr = true } },
				{ "n", "<leader>RN", ":TypescriptRenameFile<cr>" },
				{ { "n", "v" }, "<leader>ca", vim.lsp.buf.code_action },
				{ { "n", "v" }, "<leader>cx", fn.autofix },
				{ "n", "<leader>wa", vim.lsp.buf.add_workspace_folder },
				{ "n", "<leader>wr", vim.lsp.buf.remove_workspace_folder },
				{ "n", "<leader>wl", fn.list_workspace_folders },
			}
		end
		return map({
			goto_next_reference = function()
				require("illuminate").goto_next_reference()
				vim.cmd('execute "normal zz"')
			end,
			goto_prev_reference = function()
				require("illuminate").goto_prev_reference()
				vim.cmd('execute "normal zz"')
			end,
			rename = function()
				return ":IncRename " .. vim.fn.expand("<cword>")
			end,
			autofix = function()
				-- pre-save to avoid outdated cycle* errors
				vim.api.nvim_command("write")
				-- save cursor position
				local prevcursor = vim.api.nvim_win_get_cursor(0)
				-- goto to first line
				vim.api.nvim_win_set_cursor(0, { 1, 0 })
				-- add listener for when code action is applied to the buffer
				vim.api.nvim_create_augroup("CodeActionChange", { clear = true })
				vim.api.nvim_create_autocmd("TextChanged", {
					group = "CodeActionChange",
					callback = function()
						-- remove listener for code action change
						vim.api.nvim_clear_autocmds({ group = "CodeActionChange" })
						-- save changes
						vim.api.nvim_command("write")
					end,
				})
				-- run fix all auto-fixable code action
				vim.lsp.buf.code_action({
					filter = function(action)
						return string.find(action.title, "auto.fixable") ~= nil
					end,
					apply = true,
				})
				-- reset cursor
				vim.api.nvim_win_set_cursor(0, prevcursor)
			end,
			format = function()
				vim.lsp.buf.format({ async = true })
			end,
			list_workspace_folders = function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end,
		})
	end,
	diagnostic = function()
		local map = function(fn)
			return {
				{ "n", "gl", vim.diagnostic.open_float },
				{ "n", "gL", fn.toggle },
				{ "n", "gQ", vim.diagnostic.setqflist },
				{ "n", "[d", vim.diagnostic.goto_prev },
				{ "n", "]d", vim.diagnostic.goto_next },
			}
		end
		return map({
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
		sorting = {
			comparators = {
				function(entry1)
					if entry1.source.name ~= "nvim_lsp" then
						return false
					end
					return nil
				end,
				cmp.config.compare.offset,
				cmp.config.compare.exact,
				cmp.config.compare.score,
				cmp.config.compare.kind,
				cmp.config.compare.sort_text,
				cmp.config.compare.length,
				cmp.config.compare.order,
			},
		},
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "nvim_lsp_signature_help" },
			{ name = "luasnip" },
			{ name = "path" },
			{ name = "buffer", keyword_length = 3 },
		}),
		window = {
			completion = cmp.config.window.bordered({
				winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:Visual,Search:None",
			}),
			documentation = cmp.config.window.bordered({
				winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:Visual,Search:None",
				max_height = 15,
				max_width = 60,
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
	require("mason-lspconfig").setup({
		automatic_installation = {
			exclude = { "quick_lint_js" },
		},
	})

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
	lspconfig.rnix.setup(setup_opts)

	lspconfig.pylsp.setup({
		capabilities = setup_opts.capabilities,
		settings = {
			pylsp = {
				plugins = { pycodestyle = {
					ignore = { "W191", "W391" },
					maxLineLength = 100,
				} },
			},
		},
	})

	local quick_lint_js_bin = "./node_modules/.bin/quick-lint-js"
	if vim.fn.executable(quick_lint_js_bin) ~= 0 then
		lspconfig.quick_lint_js.setup({
			capabilities = setup_opts.capabilities,
			cmd = { quick_lint_js_bin, "--lsp-server" },
			filetypes = {
				"javascript",
				"javascriptreact",
				"javascript.jsx",
				"typescript",
				"typescriptreact",
				"typescript.tsx",
			},
		})
	end

	-- addons
	require("inc_rename").setup()
	require("typescript").setup({ go_to_source_definition = { fallback = true } })
	require("illuminate").configure({ providers = { "lsp" }, under_cursor = false })

	-- ui
	vim.diagnostic.config({ float = { border = "rounded" } })
	vim.cmd([[
		sign define DiagnosticSignError text=▶ texthl=DiagnosticSignError
		sign define DiagnosticSignWarn text=▶ texthl=DiagnosticSignWarn
		sign define DiagnosticSignInfo text=▶ texthl=DiagnosticSignInfo
		sign define DiagnosticSignHint text=▶ texthl=DiagnosticSignHint
	]])
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
	vim.lsp.handlers["textDocument/signatureHelp"] =
		vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

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
			-- addons
			"smjonas/inc-rename.nvim",
			"jose-elias-alvarez/typescript.nvim",
			"RRethy/vim-illuminate",
			-- cmp
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"L3MON4D3/LuaSnip",
			"onsails/lspkind.nvim",
		},
		config = config,
	},
	{
		"j-hui/fidget.nvim",
		branch = "legacy",
		config = function()
			require("fidget").setup({
				sources = {
					pylsp = { ignore = true },
				},
			})
		end,
	},
}
