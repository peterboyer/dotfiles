local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
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

	-- syntax parser
	use {
		"nvim-treesitter/nvim-treesitter",
		run = {
			":TSUpdate",
		}
	}

	-- sticky headers for functions/objects/scopes
	use {
		"nvim-treesitter/nvim-treesitter-context",
		requires = {
			{ "nvim-treesitter/nvim-treesitter" },
		}
	}

	-- lsp
	use {
		"VonHeikemen/lsp-zero.nvim",
		requires = {
			{"neovim/nvim-lspconfig"},
			{"williamboman/mason.nvim"},
			{"williamboman/mason-lspconfig.nvim"},

			{"hrsh7th/nvim-cmp"},
			{"hrsh7th/cmp-buffer"},
			{"hrsh7th/cmp-path"},
			{"hrsh7th/cmp-nvim-lsp"},
			{"hrsh7th/cmp-nvim-lua"},

			{"L3MON4D3/LuaSnip"},
			{"rafamadriz/friendly-snippets"},
		}
	}

	-- ensure installed extra tooling
	use {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		requires = {
			{ "williamboman/mason.nvim" },
		}
	}

	-- text object (l)
	use {
		"kana/vim-textobj-line",
		requires = { "kana/vim-textobj-user" },
	}

	-- trim trailing whitespace/lines
	use { "cappyzawa/trim.nvim" }

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
