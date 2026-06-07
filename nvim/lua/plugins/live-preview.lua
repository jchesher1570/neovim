-- ~/.config/nvim/lua/plugins/live-preview.lua

-- require("live-server").setup({
--   port = 8080,       -- default port
--   browser = "firefox", -- choose your browser
--   root_dir = vim.fn.getcwd(),
-- })

-- Set configuration via global variables
vim.g.live_server_port = 8080
vim.g.live_server_browser = "firefox"
vim.g.live_server_root_dir = vim.fn.getcwd()

