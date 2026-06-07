-- ~/.config/nvim/lua/plugins/bufferline.lua

return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",

  config = function()
    require("bufferline").setup({
      options = {
        diagnostics = "nvim_lsp",
        separator_style = "slant",
        always_show_bufferline = true,

        -- Nice additions 👇
        show_close_icon = false,
        show_buffer_close_icons = true,
        offsets = {
          {
            filetype = "nvim-tree",
            text = "File Explorer",
            highlight = "Directory",
            separator = true,
          },
        },
      },
    })

    -- Keymaps
    vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { silent = true })
    vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<CR>", { silent = true })
    vim.keymap.set("n", "<leader>x", "<cmd>bdelete<CR>", { silent = true })
    vim.keymap.set("n", "<leader>1", "<cmd>BufferLineGoToBuffer 1<CR>")
    vim.keymap.set("n", "<leader>2", "<cmd>BufferLineGoToBuffer 2<CR>")
  end,
}
