local keys = {
	buffer = function()
		local map = function(fn)
			return {
				-- hover
				{ "K", vim.lsp.buf.hover, desc = "Hover" },
				{ "<leader>k", vim.lsp.buf.signature_help, desc = "Hover Signature" },

				-- goto/inspect
				{ "gn", fn.goto_next_reference, desc = "Goto Next Symbol Reference" },
				{ "gN", fn.goto_prev_reference, desc = "Goto Prev Symbol Reference" },
				{ "gd", vim.lsp.buf.definition, desc = "Goto Definition" },
				{ "gD", vim.lsp.buf.implementation, desc = "Goto Implementation" },
				{ "gr", vim.lsp.buf.references, desc = "Goto References" },
				{ "gt", vim.lsp.buf.type_definition, desc = "Goto Type Definition" },

				-- format/renaming
				{ "gf", fn.format, desc = "Format" },
				{ "<leader>rn", vim.lsp.buf.rename, desc = "Rename Symbol" },
				{ "<leader>RN", ":TSToolsRenameFile<cr>", desc = "Rename File" },

				-- code actions
				{ "<leader>ca", vim.lsp.buf.code_action, desc = "Fix" },
				{ "<leader>cx", ":TSToolsFixAll<cr>", desc = "Fix All" },
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
				{ "gl", vim.diagnostic.open_float },
				{ "gL", fn.toggle },
				{ "gQ", vim.diagnostic.setqflist },
				{ "[d", vim.diagnostic.goto_prev },
				{ "]d", vim.diagnostic.goto_next },
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
	lspconfig.jsonls.setup(setup_opts)
	lspconfig.html.setup(setup_opts)
	lspconfig.tailwindcss.setup({
		capabilities = setup_opts.capabilities,
		settings = {
			-- https://github.com/tailwindlabs/tailwindcss/discussions/7554#discussioncomment-4440751
			tailwindCSS = {
				experimental = {
					classRegex = {
						{ "(?:twMerge|twJoin)\\(([^\\);]*)[\\);]", "[`'\"]([^'\"`,;]*)[`'\"]?" },
					},
				},
			},
		},
	})
	lspconfig.marksman.setup(setup_opts)
	lspconfig.bashls.setup(setup_opts)
	lspconfig.yamlls.setup(setup_opts)
	lspconfig.dockerls.setup(setup_opts)
	lspconfig.docker_compose_language_service.setup(setup_opts)

	if vim.fn.executable("cargo") ~= 0 then
		lspconfig.rnix.setup(setup_opts)
	end

	lspconfig.pylsp.setup({
		capabilities = setup_opts.capabilities,
		settings = {
			pylsp = {
				plugins = {
					pycodestyle = {
						ignore = { "W191", "W391" },
						maxLineLength = 100,
					},
				},
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
	require("typescript-tools").setup({})
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
			vim.keymap.set("n", v[1], v[2])
		end
		for _, v in pairs(keys_buffer) do
			vim.keymap.set("n", v[1], function()
				print("[" .. v[1] .. "] LSP: Not Attached")
			end, { desc = "LSP " .. v["desc"] .. " (Not Attached)" })
		end
	end
	local keymap_on_buffer = function(buffer)
		for _, v in pairs(keys_buffer) do
			vim.keymap.del("n", v[1])
			local opts = { buffer = buffer, desc = "LSP " .. v["desc"] .. " (Attached)" }
			vim.keymap.set("n", v[1], v[2], opts)
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
			"RRethy/vim-illuminate",
			{
				"pmizio/typescript-tools.nvim",
				dependencies = {
					"nvim-lua/plenary.nvim",
				},
			},
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
