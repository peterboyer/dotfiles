-- https://strdr4605.com/typescript-errors-into-vim-quickfix
vim.cmd([[
  augroup strdr4605
    autocmd FileType typescript,typescriptreact compiler tsc | setlocal makeprg=yarn\ tsc
  augroup END
]])
