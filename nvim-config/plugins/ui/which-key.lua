-- Which-key Configuration
-- Key binding helper

require("which-key").setup({
  plugins = {
    marks = true,
    registers = true,
    spelling = {
      enabled = true,
      suggestions = 20,
    },
    presets = {
      operators = false,
      motions = true,
      text_objects = true,
      windows = true,
      nav = true,
      z = true,
      g = true,
    },
  },
  replace = {
    key = {
      { "<space>", "SPC" },
      { "<cr>", "RET" },
      { "<tab>", "TAB" },
    },
  },
  icons = {
    breadcrumb = "»",
    separator = "➜",
    group = "+",
  },
  keys = {
    scroll_down = "<c-d>",
    scroll_up = "<c-u>",
  },
  win = {
    border = "rounded",
    padding = { 2, 2, 2, 2 },
    wo = {
      winblend = 0,
    },
  },
  layout = {
    height = { min = 4, max = 25 },
    width = { min = 20, max = 50 },
    spacing = 3,
    align = "left",
  },
  filter = function(mapping)
    return true
  end,
  show_help = true,
  triggers = {
    { "<auto>", mode = "nxso" },
  },
  defer = function(ctx)
    return ctx.mode == "V" or ctx.mode == "<C-V>"
  end,
})
