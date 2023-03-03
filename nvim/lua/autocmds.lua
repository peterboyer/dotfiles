-- Wrap and spellcheck for non-code files.
vim.opt.wrap = false
vim.opt.spell = false
vim.api.nvim_create_autocmd("Filetype", {
    pattern = { "gitcommit", "markdown", "text" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end
})
