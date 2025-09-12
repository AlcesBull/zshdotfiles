-- Core Keymaps
-- Essential keybindings for efficient navigation and editing

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better escape
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)

-- Better navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize windows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Move lines up and down
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Better indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Clear search highlighting
keymap("n", "<leader>h", ":nohlsearch<CR>", opts)

-- Save and quit
keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>q", ":q<CR>", opts)
keymap("n", "<leader>x", ":x<CR>", opts)

-- Buffer navigation
keymap("n", "<leader>bn", ":bnext<CR>", opts)
keymap("n", "<leader>bp", ":bprevious<CR>", opts)
keymap("n", "<leader>bd", ":bdelete<CR>", opts)

-- Quick access to common commands
keymap("n", "<leader>e", ":e ", opts)
keymap("n", "<leader>E", ":Explore<CR>", opts)

-- Terminal
keymap("n", "<leader>t", ":terminal<CR>", opts)
keymap("t", "<ESC>", "<C-\\><C-n>", opts)

-- Toggle options
keymap("n", "<leader>tw", ":set wrap!<CR>", opts)
keymap("n", "<leader>tn", ":set number!<CR>", opts)
keymap("n", "<leader>tr", ":set relativenumber!<CR>", opts)

-- Quick fix navigation
keymap("n", "]q", ":cnext<CR>", opts)
keymap("n", "[q", ":cprev<CR>", opts)
keymap("n", "]l", ":lnext<CR>", opts)
keymap("n", "[l", ":lprev<CR>", opts)

-- Better search
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Center after jumping
keymap("n", "G", "Gzz", opts)
keymap("n", "gg", "ggzz", opts)

-- Stay in visual mode after indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Better yanking
keymap("n", "Y", "y$", opts)

-- Replace word under cursor
keymap("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", opts)

-- Format code
keymap("n", "<leader>f", function()
  vim.lsp.buf.format({ async = true })
end, opts)

-- Diagnostic navigation
keymap("n", "]d", vim.diagnostic.goto_next, opts)
keymap("n", "[d", vim.diagnostic.goto_prev, opts)
keymap("n", "<leader>d", vim.diagnostic.open_float, opts)
