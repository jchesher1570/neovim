-- ~/.config/nvim/lua/config/keymaps.lua

local keymap = vim.keymap

vim.g.mapleader = " "

-- File explorer
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- Save / quit
keymap.set("n", "<leader>w", ":w<CR>")
keymap.set("n", "<leader>q", ":q<CR>")

-- Neogit
keymap.set("n", "<leader>gg", ":Neogit<CR>")

