---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "oceanic-next",
  theme_toggle = { "oceanic-next", "one_light" },

  hl_override = highlights.override,
  hl_add = highlights.add,
  nvdash = {
    load_on_startup = true,
    header = {
      "       TRONGTHANH NVIM IDE        ",
      "       Based on NvChad 2.0        ",
      "   github.com/trongthanh/nvchad   ",
    },
    buttons = {
      { "  Find File", "Ctrl-p", "Telescope find_files" },
      { "󰙅  File explorer", "Ctrl-b", "NvimTreeToggle" },
      { "󰈚  Recent Files", "Spc f o", "Telescope oldfiles" },
      { "󰈭  Find Word", "Spc f w", "Telescope live_grep" },
      { "  Bookmarks", "Spc m a", "Telescope marks" },
      { "  Themes", "Spc t h", "Telescope themes" },
      { "  Mappings", "Spc c h", "NvCheatsheet" },
    },
  },
  statusline = {
    theme = "default", -- default/vscode/vscode_colored/minimal
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = "default",
    -- used to display gitblame but not neccessary anymore
    overriden_modules = function(modules)
      -- see https://nvchad.com/docs/config/nvchad_ui#override_statusline_modules
      -- display line & column number
      table.insert(modules, "%l:%c")
      -- below to display gitblame in statusline, but it's laggy due to async call
      -- table.insert(
      --   modules,
      --   4,
      --   (function()
      --     if vim.b.gitsigns_blame_line then
      --       return vim.b.gitsigns_blame_line
      --     end
      --   end)()
      -- )
    end,
  },
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
