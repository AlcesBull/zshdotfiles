-- Neovim Configuration
-- High-quality setup with minimap and QOL features

-- Bootstrap Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Configure Lazy.nvim
require("lazy").setup({
  spec = {
    -- Import all plugin specs
    { import = "plugins.init" },
  },
  defaults = {
    lazy = false, -- plugins are loaded immediately
    version = "*", -- try installing the latest stable version
  },
  install = { colorscheme = { "tokyonight" } },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- Load core configuration
require("core.options")
require("core.keymaps")
require("core.autocmds")
