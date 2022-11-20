local M = {
  config = function ()
    require("mason").setup()
  end,
  config_lsp = function()
    local servers = { "tsserver", "eslint", "rust_analyzer", "sumneko_lua" }
    require("mason-lspconfig").setup({
      ensure_installed = servers
    })
  end,
  config_tools = function ()
    require('mason-tool-installer').setup {
      ensure_installed = {
        'node-debug2-adapter'
      }
    }
  end
}

return M
