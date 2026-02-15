-- ~/.config/nvim/init.lua

-----------------------------------------------------------
-- Basic Neovim settings
-----------------------------------------------------------
vim.g.mapleader = " "
vim.o.number = true
vim.o.relativenumber = true
vim.o.termguicolors = true
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.smartindent = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.cursorline = true

-----------------------------------------------------------
-- Transparent background + ST colors
-----------------------------------------------------------
local colors = {
  black      = "#000000",
  white      = "#ffffff",
  green      = "#7b866a",
  purple     = "#c990fc",
  darkgreen  = "#565f4a",
  orange     = "#d39758",
  yellow     = "#e0931e",
  brightyellow = "#FFF94F",
  cyan       = "#39E7ED",
  pink       = "#FF9EAF",
  lightgreen = "#d6e9bb",
  lightyellow= "#FFEA87",
  lightpink  = "#fba5c8",
  blue       = "#2FB0D7",
  lightbrown = "#a5b490",
  lightmagenta = "#f7c4d7",

  cursor     = "#add8e6",
  revcursor  = "#555555",
  bg         = "NONE", -- transparent background
  fg         = "#f38813",
}

-- Apply highlights
vim.cmd(string.format("hi Normal guibg=%s guifg=%s", colors.bg, colors.fg))
vim.cmd(string.format("hi NormalNC guibg=%s guifg=%s", colors.bg, colors.fg))
vim.cmd(string.format("hi LineNr guifg=%s guibg=%s", colors.lightbrown, colors.bg))
vim.cmd(string.format("hi CursorLine guibg=%s", colors.revcursor))
vim.cmd(string.format("hi Visual guibg=%s", colors.lightyellow))
vim.cmd(string.format("hi Comment guifg=%s guibg=%s", colors.green, colors.bg))
vim.cmd(string.format("hi Function guifg=%s guibg=%s", colors.purple, colors.bg))
vim.cmd(string.format("hi Keyword guifg=%s guibg=%s", colors.orange, colors.bg))
vim.cmd(string.format("hi String guifg=%s guibg=%s", colors.lightgreen, colors.bg))
vim.cmd(string.format("hi Number guifg=%s guibg=%s", colors.yellow, colors.bg))
vim.cmd(string.format("hi Type guifg=%s guibg=%s", colors.cyan, colors.bg))

-- Keep splits, statusline, and extra elements transparent
vim.cmd([[
  hi VertSplit guibg=NONE
  hi StatusLine guibg=NONE
  hi NonText guibg=NONE
  hi EndOfBuffer guibg=NONE
]])

-----------------------------------------------------------
-- Bootstrap lazy.nvim plugin manager
-----------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-----------------------------------------------------------
-- Plugins
-----------------------------------------------------------
require("lazy").setup({
  { "nvim-lua/plenary.nvim" },
  { "nvim-telescope/telescope.nvim", tag = "0.1.6" },
  { "nvim-tree/nvim-tree.lua" },
  { "nvim-tree/nvim-web-devicons" },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "L3MON4D3/LuaSnip" },
  { "norcalli/nvim-colorizer.lua" }, -- colorizer plugin
  -- Add visual-multi for live multi-line editing
  { "mg979/vim-visual-multi", branch = "master", lazy = false },
})

-----------------------------------------------------------
-- Plugin setups
-----------------------------------------------------------
require("nvim-tree").setup()
require("colorizer").setup()
require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua", "python", "bash", "json", "yaml", "html", "css", "javascript" },
  highlight = { enable = true },
})

-----------------------------------------------------------
-- Keybindings
-----------------------------------------------------------
local keymap = vim.keymap.set
keymap("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file explorer" })
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find Buffers" })

-----------------------------------------------------------
-- LSP + Autocompletion (version-safe)
-----------------------------------------------------------
local cmp = require("cmp")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "buffer" },
  }),
})

-- Mason LSP servers
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "pyright", "bashls", "ts_ls" },
})

-- Safe LSP initialization (no warnings, supports Neovim ≥0.11 and ≤0.10)
local servers = {
  lua_ls = "lua-language-server",
  pyright = "pyright",
  bashls = "bash-language-server",
  ts_ls = "typescript-language-server",
}


if vim.lsp and vim.lsp.start then
  -- Neovim ≥0.11
  for _, name in ipairs(servers) do
    local ok, cfg = pcall(require, "lspconfig.server_configurations." .. name)
    if ok and cfg then
      vim.lsp.start({
        name = name,
        cmd = cfg.default_config.cmd,
        filetypes = cfg.default_config.filetypes,
        capabilities = capabilities,
      })
    else
      print("⚠ LSP server not found:", name)
    end
  end
else
  -- Neovim ≤0.10 fallback
  local lspconfig = require("lspconfig")
  for _, srv in ipairs(servers) do
    if lspconfig[srv] then
      lspconfig[srv].setup({ capabilities = capabilities })
    end
  end
end

-- Use Ctrl+Q for block visual mode (for st or terminals that steal Ctrl+V)
vim.keymap.set("n", "<C-q>", "<C-v>")

