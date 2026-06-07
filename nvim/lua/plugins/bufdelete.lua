-- ~/.config/nvim/lua/plugins/bufdelete.lua

return {
  "famiu/bufdelete.nvim",

  config = function()
    vim.keymap.set("n", "<leader>x", "<cmd>Bdelete<CR>", {
      silent = true,
      desc = "Close buffer (preserve layout)",
    })
  end,
}
