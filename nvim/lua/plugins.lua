local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
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

-- init/config plugins
return require("packer").startup(function(use)
  -- packer
  use "wbthomason/packer.nvim"

  -- base config
  use "tpope/vim-sensible"

  -- statusline
  use 'vim-airline/vim-airline'

  -- delete buffers without messing the layout
  use "moll/vim-bbye"

  -- auto parenthesis
  use "cohama/lexima.vim"

  -- add/swap/del brackets/quotes
  use "tpope/vim-surround"

  -- commenting
  use {
    "preservim/nerdcommenter",
    config = function()
      -- spaces after comment delimiters
      vim.g.NERDSpaceDelims = 1
    end,
  }

  -- git tooling (blame)
  use "tpope/vim-fugitive"

  -- git gutter (diff in the sign column)
  use "airblade/vim-gitgutter"

  -- add select all/trimmed line as text object (l)
  use {
    "kana/vim-textobj-line",
    requires = {
      "kana/vim-textobj-user",
    },
  }

  -- fuzzy file searching
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
    config = require("plugins-telescope").config
  }

  -- ripgrep for quickfix flist
  use "jremmen/vim-ripgrep"

  use {
    "ptzz/lf.vim",
    requires = {
      "voldikss/vim-floaterm",
    },
    config = function()
      vim.g.lf_map_keys = 0
    end
  }

  -- formatting
  use {
    "sbdchd/neoformat",
    config = require("plugins-neoformat").config
  }

  -- language parsing
  use {
    "nvim-treesitter/nvim-treesitter",
    run = {
      ":TSUpdate",
      ":TSInstall html css javascript typescript json yaml bash vim lua dockerfile make rust",
    },
  }

  use {
    "williamboman/mason.nvim",
    config = require("plugins-mason").config
  }

  use {
    "williamboman/mason-lspconfig.nvim",
    requires = {
      "williamboman/mason.nvim",
    },
    config = require("plugins-mason").config_lsp
  }

  use {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    requires = {
      "williamboman/mason.nvim",
    },
    config = require("plugins-mason").config_tools
  }

  use {
    "neovim/nvim-lspconfig",
    requires = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
    },
    config = require("plugins-lsp").config
  }

  use {
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      'marilari88/neotest-vitest',
    },
    config = require("plugins-neotest").config
  }

  use {
    "mxsdev/nvim-dap-vscode-js",
    requires = {
      "mfussenegger/nvim-dap",
    },
    config = require("plugins-dap").config
  }

  if packer_bootstrap then
    require("packer").sync()
  end
end)
