-- ~/.config/nvim/lua/plugins/nvim-tree.lua

require("nvim-tree").setup({
  view = {
    width = 30,
    side = "left",
  },

  renderer = {
    indent_markers = { enable = true },
    icons = {
      show = {
        git = true,
        folder = true,
        file = true,
        folder_arrow = true,
      },
    },
  },

  git = { enable = true },

  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },

  update_focused_file = {
    enable = true,
    update_cwd = true,
  },

  sync_root_with_cwd = true,
  respect_buf_cwd = true,

  actions = {
    open_file = {
      quit_on_open = false,
    },
  },

  on_attach = function(bufnr)
    local api = require("nvim-tree.api")

    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
    vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
    vim.keymap.set("n", "v", api.node.open.vertical, opts("Open Vertical"))
 end,
})

