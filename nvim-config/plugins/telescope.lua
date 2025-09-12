-- Telescope Configuration
-- Fuzzy finder for files, buffers, and more

local telescope = require("telescope")
local builtin = require("telescope.builtin")

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<C-d>"] = false,
      },
    },
  },
  pickers = {
    find_files = {
      hidden = true,
    },
  },
})

-- Keymaps
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" })
vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "Commands" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Keymaps" })
vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Document symbols" })
vim.keymap.set("n", "<leader>fS", builtin.lsp_workspace_symbols, { desc = "Workspace symbols" })
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>fD", builtin.lsp_definitions, { desc = "Definitions" })
vim.keymap.set("n", "<leader>fr", builtin.lsp_references, { desc = "References" })
vim.keymap.set("n", "<leader>fi", builtin.lsp_implementations, { desc = "Implementations" })
vim.keymap.set("n", "<leader>ft", builtin.lsp_type_definitions, { desc = "Type definitions" })
