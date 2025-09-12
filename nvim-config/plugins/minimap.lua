-- Minimap Configuration
-- codewindow.nvim - A minimap plugin for Neovim

local codewindow = require("codewindow")

codewindow.setup({
  -- Whether to automatically open the minimap when entering a buffer
  auto_enable = true,
  
  -- Whether to show the current line in the minimap
  show_cursor = true,
  
  -- Whether to show the current line number in the minimap
  show_line_number = true,
  
  -- The width of the minimap window
  width = 20,
  
  -- The height of the minimap window (0 = auto)
  height = 0,
  
  -- The position of the minimap window
  position = "right",
  
  -- Whether to show the minimap in insert mode
  show_in_insert = false,
  
  -- Whether to show the minimap in terminal mode
  show_in_terminal = false,
  
  -- The highlight group for the current line in the minimap
  highlight_cursor_line = "CodewindowCursorLine",
  
  -- The highlight group for the current line number in the minimap
  highlight_line_number = "CodewindowLineNumber",
  
  -- The highlight group for the minimap background
  highlight_background = "CodewindowBackground",
  
  -- The highlight group for the minimap border
  highlight_border = "CodewindowBorder",
  
  -- Whether to show a border around the minimap
  show_border = true,
  
  -- The characters to use for the border
  border_chars = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
  
  -- Whether to show the minimap in diff mode
  show_in_diff = true,
  
  -- Whether to show the minimap in help files
  show_in_help = false,
  
  -- Whether to show the minimap in quickfix lists
  show_in_quickfix = false,
  
  -- Whether to show the minimap in location lists
  show_in_location = false,
  
  -- Whether to show the minimap in terminal buffers
  show_in_terminal_buffers = false,
  
  -- Whether to show the minimap in special buffers
  show_in_special_buffers = false,
  
  -- Whether to show the minimap in unlisted buffers
  show_in_unlisted_buffers = false,
  
  -- Whether to show the minimap in scratch buffers
  show_in_scratch_buffers = false,
  
  -- Whether to show the minimap in nofile buffers
  show_in_nofile_buffers = false,
  
  -- Whether to show the minimap in nowrite buffers
  show_in_nowrite_buffers = false,
  
  -- Whether to show the minimap in readonly buffers
  show_in_readonly_buffers = true,
  
  -- Whether to show the minimap in modifiable buffers
  show_in_modifiable_buffers = true,
  
  -- Whether to show the minimap in non-modifiable buffers
  show_in_non_modifiable_buffers = false,
})

-- Keymaps for minimap
vim.keymap.set("n", "<leader>mm", function()
  local codewindow = require('codewindow')
  codewindow.toggle_minimap()
end, { desc = "Toggle minimap" })
