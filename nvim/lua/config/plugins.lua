-- ~/.config/nvim/lua/config/plugins.lua

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "https://github.com/folke/lazy.nvim",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Core Plugins
    { "nvim-tree/nvim-web-devicons" }, 

    -- LSP
    { "neovim/nvim-lspconfig" },

    -- Autocomplete
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "L3MON4D3/LuaSnip" },

    -- Git
    { "nvim-lua/plenary.nvim" },
    { "NeogitOrg/neogit", config = function()
        require("plugins.neogit")
    end },

    -- Colorizer
    { "norcalli/nvim-colorizer.lua", config = function()
        require("plugins.colorizer")
    end },

    -- Live preview
    { "barrett-ruth/live-server.nvim", config = function()
        require("plugins.live-preview")
    end },

    -- Treesitter
    { "nvim-treesitter/nvim-treesitter", config = function()
        require("plugins.treesitter")
    end },

    -- NeoTree
    { "MunifTanjim/nui.nvim" },
    { "nvim-neo-tree/neo-tree.nvim", config = function()
        require("plugins.neotree")
   end },

    -- Tabs (bufferline)
    { "akinsho/bufferline.nvim", config = function()
        require("plugins.bufferline")
    end },

    -- Close Buffers
    { "famiu/bufdelete.nvim" },

    -- Telescope
    { "BurntSushi/ripgrep" },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { "nvim-telescope/telescope.nvim", config = function()
        require("plugins.telescope")
    end },

    -- Colorscheme
    { "dasupradyumna/midnight.nvim" }
})

