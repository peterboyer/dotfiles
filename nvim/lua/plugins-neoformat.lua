local M = {
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

return M
