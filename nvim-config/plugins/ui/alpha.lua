-- Alpha Configuration
-- Start screen

local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
  "                                                     ",
  "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
  "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
  "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
  "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
  "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
  "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
  "                                                     ",
  "                   [ Neovim ]                        ",
  "                                                     ",
}

dashboard.section.buttons.val = {
  dashboard.button("f", "󰈞  Find file", ":Telescope find_files <CR>"),
  dashboard.button("e", "󰝒  New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("r", "󰄉  Recently used files", ":Telescope oldfiles <CR>"),
  dashboard.button("t", "󰅴  Find text", ":Telescope live_grep <CR>"),
  dashboard.button("c", "󰒓  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
  dashboard.button("q", "󰗼  Quit Neovim", ":qa<CR>"),
}

local function footer()
  local datetime = os.date("󰥔 %d-%m-%Y   %H:%M:%S")
  local version = vim.version()
  local nvim_version_info = "  󰀲 v" .. version.major .. "." .. version.minor .. "." .. version.patch
  return datetime .. nvim_version_info
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
