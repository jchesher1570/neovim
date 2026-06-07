-- ~/.config/nvim/lua/plugins/neotree.lua

require("neo-tree").setup({
    view = {
        width = 30,
        side = "left",
    },

    window = {
        mappings = {
            ["l"] = "open",   -- open file
            ["h"] = "close_node", -- collapse folder
        },
    },
})

-- Global keymaps (outside setup!)
vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle Neo-tree" })
vim.keymap.set("n", "<leader>o", ":Neotree focus<CR>", { desc = "Focus Neo-tree" })

-- Window navigation (works everywhere, not just Neo-tree)
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move left" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move right" })

