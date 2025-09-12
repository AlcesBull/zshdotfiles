-- Core Neovim Options
-- Essential settings for a modern Neovim experience

local opt = vim.opt
local g = vim.g

-- General settings
opt.mouse = "a" -- Enable mouse support
opt.clipboard = "unnamedplus" -- Use system clipboard
opt.swapfile = false -- Don't create swap files
opt.backup = false -- Don't create backup files
opt.writebackup = false -- Don't create backup files while editing
opt.undofile = true -- Enable persistent undo
opt.undolevels = 10000 -- Maximum number of undo levels

-- Display settings
opt.number = true -- Show line numbers
opt.relativenumber = true -- Show relative line numbers
opt.cursorline = true -- Highlight current line
opt.signcolumn = "yes" -- Always show sign column
opt.colorcolumn = "80" -- Show column at 80 characters
opt.scrolloff = 8 -- Keep 8 lines visible when scrolling
opt.sidescrolloff = 8 -- Keep 8 columns visible when scrolling horizontally
opt.wrap = false -- Don't wrap lines
opt.linebreak = true -- Break lines at word boundaries when wrapping
opt.showbreak = "↪" -- Show line break indicator

-- Search settings
opt.ignorecase = true -- Ignore case in search
opt.smartcase = true -- Use case-sensitive search if uppercase is used
opt.hlsearch = true -- Highlight search results
opt.incsearch = true -- Show search results as you type

-- Tab and indentation
opt.tabstop = 2 -- Number of spaces a tab represents
opt.shiftwidth = 2 -- Number of spaces for indentation
opt.expandtab = true -- Use spaces instead of tabs
opt.smartindent = true -- Smart indentation
opt.autoindent = true -- Auto indentation

-- Completion settings
opt.completeopt = { "menu", "menuone", "noselect" } -- Completion options
opt.shortmess:append("c") -- Don't show completion messages

-- Performance settings
opt.updatetime = 250 -- Faster completion
opt.timeoutlen = 300 -- Time to wait for key sequence
opt.ttimeoutlen = 10 -- Time to wait for key code sequence

-- Window settings
opt.splitbelow = true -- Open horizontal splits below
opt.splitright = true -- Open vertical splits to the right
opt.equalalways = false -- Don't resize windows equally

-- File settings
opt.autoread = true -- Automatically read file changes
opt.autowrite = true -- Automatically write file before some commands
opt.confirm = true -- Confirm before quitting with unsaved changes

-- Terminal settings
opt.termguicolors = true -- Enable true color support

-- Disable some built-in plugins
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_matchit = 1
g.loaded_matchparen = 1
g.loaded_2html_plugin = 1
g.loaded_logiPat = 1
g.loaded_rrhelper = 1
g.loaded_tarPlugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_gzip = 1
g.loaded_tutor_mode_plugin = 1
