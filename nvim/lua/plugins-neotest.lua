local M = {
    config = function ()
      require("neotest").setup({
        adapters = {
          require('neotest-vitest')
        }
      })
    end
}

return M
