local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

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

  -- theme
  use {
    "pbrisbin/vim-colors-off",
    config = function()

    end,
  }

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
    config = function()
      require("telescope").setup{
        defaults = {
          file_ignore_patterns = {
            "%.git/",
            "%.yarn/",
          },
          path_display = { "truncate" }
        },
        pickers = {
          find_files = {
            follow = true, -- follow symlinks
            hidden = true, -- show dotfiles
          },
        },
      }
    end,
  }

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
    config = function()
      -- attempt to use project prettier first
      vim.g.neoformat_try_node_exe = 1

      -- format on save
      vim.api.nvim_exec([[
      function! TrimTrailingWhitespace()
      let _save_pos=getpos(".")
      let _s=@/
      %s/\s\+$//e
      let @/=_s
      nohl
      unlet _s
      call setpos(".", _save_pos)
      unlet _save_pos
      endfunction

      augroup fmt
      autocmd!
      " all files: trim trailing whitespace
      autocmd BufWritePre * call TrimTrailingWhitespace()
      " js/ts files: format documents (like prettier)
      autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx Neoformat
      augroup END
      ]], true)
    end,
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
    config = function()
      require("mason").setup()
    end
  }

  use {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      local servers = { "tsserver", "eslint", "rust_analyzer", "sumneko_lua" }
      require("mason-lspconfig").setup({
        ensure_installed = servers
      })
    end
  }

  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-vsnip"
  use "hrsh7th/vim-vsnip"

  use {
    "neovim/nvim-lspconfig",
    config = function()
      local servers = { "tsserver", "eslint", "rust_analyzer", "sumneko_lua" }
      local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

      for _, lsp in pairs(servers) do
        require("lspconfig")[lsp].setup {
          on_attach = lsp_on_attach,
          capabilities = capabilities,
        }
      end

      vim.o.completeopt = "menu,menuone,noselect"

      local cmp = require 'cmp'
      cmp.setup {
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = {
          { name = 'nvim_lsp' },
          { name = 'vsnip' },
        },
      }
    end,
  }

  -- debugging services
  -- use {
  -- "mfussenegger/nvim-dap",
  -- requires = {
  -- {
  -- "microsoft/vscode-node-debug2",
  -- run = {
  -- (":! (" ..
  -- table.concat({
  -- "cd " .. get_plugin_path("vscode-node-debug2"),
  -- "npm install",
  -- "source /usr/share/nvm/init-nvm.sh",
  -- "nvm use 16",
  -- "npm run build",
  -- }, " && ") ..
  -- ")")
  -- },
  -- config = function()
  -- local dap = require('dap')

  -- dap.adapters.node2 = {
  -- type = 'executable',
  -- command = 'node',
  -- args = {
  -- get_plugin_path("vscode-node-debug2") ..
  -- '/out/src/nodeDebug.js',
  -- },
  -- }

  -- dap.configurations.typescript = {
  -- {
  -- name = 'Launch',
  -- type = 'node2',
  -- request = 'launch',
  -- program = '${file}',
  -- cwd = vim.fn.getcwd(),
  -- sourceMaps = true,
  -- protocol = 'inspector',
  -- console = 'integratedTerminal',
  -- },
  -- {
  -- -- For this to work you need to make sure the node process is started with the `--inspect` flag.
  -- name = 'Attach to process',
  -- type = 'node2',
  -- request = 'attach',
  -- processId = require'dap.utils'.pick_process,
  -- },
  -- }
  -- end,
  -- },
  -- },
  -- }

  -- use {
  -- "david-kunz/jester",
  -- config = function()
  -- require("jester").setup({
  -- -- use yarn to hoist to correct jest bin if in workspace
  -- path_to_jest = "yarn test",
  -- path_to_jest_debug = "yarn test",
  -- -- set cd of split terminal to directory of testing file for correct config resolution if in workspace
  -- terminal_cmd = ":split | :lcd %:p:h | terminal",
  -- })
  -- end
  -- }

  -- Execute PackerSync if the Packer plugin was just installed.
  if packer_bootstrap then
    require("packer").sync()
  end
end)
