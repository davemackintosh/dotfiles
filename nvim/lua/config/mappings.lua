local M = {}

function M.setup()
    local mapx = require "mapx".setup { global = true }

    -- Better window swapping
    mapx.nnoremap("<C-h>", "<C-w>h")
    mapx.nnoremap("<C-j>", "<C-w>j")
    mapx.nnoremap("<C-k>", "<C-w>k")
    mapx.nnoremap("<C-l>", "<C-w>l")

    -- Utils
    mapx.nnoremap("<C-o>", ":NvimTreeToggle<Cr>")
    mapx.nnoremap("<C-p>", ":Telescope find_files<Cr>")
    mapx.nnoremap("<C-s>", ":Vista!!<Cr>")
    mapx.nnoremap("<C-f>", ":lua vim.lsp.buf.rename()<Cr>")
    mapx.nnoremap("gd", ":lua vim.lsp.buf.definition()<Cr>")
    mapx.nnoremap("K", ":lua vim.lsp.buf.hover()<Cr>")

    mapx.nnoremap("<C-/>", ":Commentary<Cr>")
end

return M
