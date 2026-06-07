-- ~/.config/nvim/lua/plugins/telescope.lua

local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
    defaults = {
        prompt_prefix = "  ",
        selection_caret = " ",
        path_display = { "smart" },

        file_ignore_patterns = {
            "node_modules",
            ".git/",
            "dist",
            "build",
        },

        mappings = {
            i = {
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            },
        },
    },

    pickers = {
        find_files = {
            hidden = true, -- show dotfiles
        },
    },

    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown({})
        },
    },
})

-- Load extensions
telescope.load_extension("fzf")
telescope.load_extension("ui-select")

-- Keymaps
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" })
vim.keymap.set("n", "<leader>fs", builtin.current_buffer_fuzzy_find, { desc = "Search in buffer" })

-- NEW: search from home directory
vim.keymap.set("n", "<leader>fH", function()
    builtin.find_files({ cwd = vim.fn.expand("~") })
end, { desc = "Find files (home)" })

-- NEW: search from root directory
vim.keymap.set("n", "<leader>fR", function()
    builtin.find_files({ cwd = "/" })
end, { desc = "Find files (root)" })
