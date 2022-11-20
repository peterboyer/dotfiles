local M = {
  config = function()
    require("dap-vscode-js").setup({
      adapters = { 'pwa-node' },
      debugger_path = vim.fn.stdpath('data')..'/mason/packages/js-debug-adapter',
    })

    for _, language in ipairs({ "typescript", "javascript" }) do
      require("dap").configurations[language] = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch",
          program = "${file}",
          cwd = "${workspaceFolder}",
          runtimeExecutable = "node",
          runtimeArgs = {
            "./node_modules/vitest/vitest.mjs"
          }
        }
      }
    end

  end
}

return M
