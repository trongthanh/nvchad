-- Path to overriding theme and highlights files
local highlights = require "highlights"

---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "oceanic-next",
  theme_toggle = { "oceanic-next", "one_light" },

  hl_override = highlights.override,
  hl_add = highlights.add,

  nvdash = {
    load_on_startup = false,
    header = {
      "       TRONGTHANH NVIM IDE        ",
      "       Based on NvChad 2.5        ",
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
    order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd", "cursor", "loc" },
    modules = {
      -- see https://nvchad.com/docs/config/nvchad_ui#override_statusline_modules
      -- display line & column number
      loc = "%l:%c",
      -- below to display gitblame in statusline, but it's laggy due to async call
      -- blame = function()
      --   if vim.b.gitsigns_blame_line then
      --     return vim.b.gitsigns_blame_line
      --   end
      -- end
    },
  },
}

return M
