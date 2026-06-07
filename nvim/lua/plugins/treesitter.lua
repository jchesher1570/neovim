-- ~/.config/nvim/lua/plugins/treesitter.lua

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",  -- using the backwards compatibility branch
  version = false,   -- 🔑 secure branch and prevent switches
  build = ":TSUpdate",
  lazy = false, -- critical

  config = function()
      local parser_dir = vim.fn.stdpath("data") .. "/site/parser"

      -- Add parser dir to runtimepath so Neovim sees installed parsers
      vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/site")
      vim.opt.runtimepath:append(parser_dir)

      require("nvim-treesitter.configs").setup({
          ensure_installed = { "c", "lua", "bash", "html", "css", "javascript", "vim", "query" },
          auto_install = true,
          highlight = { enable = true, additional_vim_regex_highlighting = false,},
      })
  end,
}
