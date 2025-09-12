-- Core Autocommands
-- Automatic commands for enhanced functionality

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
local highlight_group = augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- Auto-resize splits when window is resized
autocmd("VimResized", {
  pattern = "*",
  command = "wincmd =",
})

-- Automatically create directories for new files
autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local file = vim.fn.expand("<afile>")
    local dir = vim.fn.fnamemodify(file, ":p:h")
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
})

-- Auto-save on focus lost
autocmd("FocusLost", {
  pattern = "*",
  command = "silent! wa",
})

-- Return to last edit position when opening files
autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Filetype-specific settings
autocmd("FileType", {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    pcall(function()
      vim.cmd([[%s/\s\+$//e]])
    end)
    vim.fn.setpos(".", save_cursor)
  end,
})

-- Auto-format on save for specific filetypes
autocmd("BufWritePre", {
  pattern = { "*.lua", "*.go", "*.rs", "*.py", "*.js", "*.ts", "*.jsx", "*.tsx" },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- Set filetype for specific files
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.zsh", "*.zshrc" },
  command = "set filetype=zsh",
})

-- Disable line numbers in terminal
autocmd("TermOpen", {
  pattern = "*",
  command = "setlocal nonumber norelativenumber",
})

-- Auto-close quickfix and location lists
autocmd("FileType", {
  pattern = { "qf" },
  callback = function()
    vim.keymap.set("n", "q", ":close<CR>", { buffer = true })
  end,
})
