-- ~/.config/nvim/lua/plugins/lsp.lua

local lspconfig = require("lspconfig")

-- Example: Lua LSP
lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
    },
  },
})
