local M = {}

function M.setup()
    local mapx = require "mapx".setup()

    -- Better window swapping
    mapx.nnoremap("<C-h>", "<C-w>h")
    mapx.nnoremap("<C-j>", "<C-w>j")
    mapx.nnoremap("<C-k>", "<C-w>k")
    mapx.nnoremap("<C-l>", "<C-w>l")

    -- Utils
    mapx.nnoremap("<C-u>", ":source $MYVIMRC<Cr>:PackerSync<Cr>")
    mapx.nnoremap("<C-o>", ":CocCommand explorer<Cr>")
    mapx.nnoremap("<C-p>", ":Telescope find_files<Cr>")
    mapx.nnoremap("<C-s>", ":Vista!!<Cr>")

    mapx.nnoremap("<C-/>", ":Commentary<Cr>")
    --[[mapx.nnoremap("<F5>", ":DlvTest<Cr>")
    mapx.nnoremap("<C-F5>", ":DlvTestCurrent<Cr>")
    mapx.nnoremap("<F6>", ":DlvDebug<Cr>")]]
end

return M
