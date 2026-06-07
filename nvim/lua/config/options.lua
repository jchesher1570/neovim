-- ~/.config/nvim/lua/config/options.lua

local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.smartindent = true
opt.wrap = false

opt.termguicolors = true
opt.cursorline = true

-- Synchronises the system clipboard
-- with Neovim's clipboard
-- opt.clipboard = "unnamedplus"

opt.splitright = true
opt.splitbelow = true

vim.opt.scrolloff = 999

vim.opt.virtualedit = "block"

vim.opt.inccommand = "split"

vim.opt.ignorecase = true

vim.opt.rtp:prepend("/home/james/.local/share/nvim/site")

