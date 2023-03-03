local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerCompile
	augroup end
]])

return require("packer").startup(function(use)
	use { "wbthomason/packer.nvim" }

	-- fuzzy finder
	use {
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	}

	-- syntax ast
	use {
		"nvim-treesitter/nvim-treesitter",
		run = {
			":TSUpdate",
		},
	}

	-- syntax ast sticky headers
	use {
		"nvim-treesitter/nvim-treesitter-context",
		requires = {
			{ "nvim-treesitter/nvim-treesitter" },
		},
	}

	-- lsp

	use {
		"VonHeikemen/lsp-zero.nvim",
		requires = {
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },

			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	}

	-- lsp faster
	use {
		"jose-elias-alvarez/null-ls.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	}

	-- lsp incremental rename

	use { "smjonas/inc-rename.nvim" }

	-- lsp list all errors

	use {
		"folke/trouble.nvim",
		requires = {
			"nvim-tree/nvim-web-devicons",
		},
	}

	-- lsp enhanced typescript (renaming/refactoring)

	use {
		"jose-elias-alvarez/typescript.nvim",
		requires = {
			"jose-elias-alvarez/null-ls.nvim",
		},
	}

	-- dap
	use {
		"mxsdev/nvim-dap-vscode-js",
		requires = {
			{ "mfussenegger/nvim-dap" },
			{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
		},
	}

	-- dap inline values
	use {
		"theHamsta/nvim-dap-virtual-text",
		requires = {
			{ "mfussenegger/nvim-dap" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	}

	-- neotest
	use {
		"nvim-neotest/neotest",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
		},
	}

	-- neotest jest integration
	use {
		"haydenmeade/neotest-jest",
		requires = {
			{ "nvim-neotest/neotest" },
		},
	}

	-- lf
	use {
		"ptzz/lf.vim",
		requires = {
			"voldikss/vim-floaterm"
		},
	}

	-- text object (l)
	use {
		"kana/vim-textobj-line",
		requires = { "kana/vim-textobj-user" },
	}

	-- trim trailing whitespace/lines
	use { "cappyzawa/trim.nvim" }

	-- toggle quickfix/locationlist
	use { "milkypostman/vim-togglelist" }

	-- language specific formatting
	use { "sbdchd/neoformat" }

	-- commenting shortcuts
	use { "preservim/nerdcommenter" }

	-- auto closing bracket/quotes
	use { "cohama/lexima.vim" }

	-- add/change/delete surrounding brackets/quotes/tags
	use { "tpope/vim-surround" }

	-- delete buffers without messing the layout
	use { "moll/vim-bbye" }

	-- git tooling (blame)
	use { "tpope/vim-fugitive" }

	-- fs tooling (rename buffer and file)
	use { "tpope/vim-eunuch" }

	-- git gutter (diff in the sign column)
	use { "airblade/vim-gitgutter" }

	-- ripgrep into quickfix (:Rg <string|pattern>)
	use { "jremmen/vim-ripgrep" }

	-- project specific vim config options
	use { "embear/vim-localvimrc" }

	if packer_bootstrap then
		require("packer").sync()
	end
end)
