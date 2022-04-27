local M = {}

function M.setup()
    vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)
    vim.api.nvim_exec([[ autocmd BufWritePre *.mod :silent! lua require('go.format').goimport() ]], false)
end

return M
