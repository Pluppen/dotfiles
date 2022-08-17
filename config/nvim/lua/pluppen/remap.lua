local nnoremap = require("pluppen.keymap").nnoremap
local inoremap = require("pluppen.keymap").inoremap

-- nnoremap("<C-CR>", "<cmd>NERDTree<CR>")
nnoremap("<C-CR>", "<cmd>NERDTreeToggle<CR>")
nnoremap("<C- >", "<cmd>NERDTreeToggle<CR>")

nnoremap("<leader>pv", "<cmd>Ex<CR>")
nnoremap("<leader>ff", "<cmd>Telescope find_files<CR>")

function pumvisible()
    return vim.fn.pumvisible ~= 0
end

inoremap("<Tab>", 'pumvisible() ? "<C-n>" : "<Tab>"', {
    expr = true,
    noremap = false
})

inoremap("<S-Tab>", 'pumvisible() ? "<C-p>" : "<S-Tab>"', {
    expr = true,
    noremap = false
})
