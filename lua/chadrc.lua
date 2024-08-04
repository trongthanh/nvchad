-- Path to overriding theme and highlights files
local highlights = require "highlights"
local blame_deferred = false
---@type ChadrcConfig
local M = {}

M.ui = {
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
    order = { "mode", "file", "git", "blame", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd", "cursor", "loc" },
    modules = {
      -- see https://nvchad.com/docs/config/nvchad_ui#override_statusline_modules
      -- display line & column number
      loc = "%l:%c",
      -- display gitblame in statusline, the defer_fn is necessary due to blame is async
      blame = function()
        if not blame_deferred then
          vim.defer_fn(function()
            blame_deferred = true
            vim.cmd "redrawstatus"
          end, 200)
          return vim.b.gitsigns_blame_line or ""
        end
        blame_deferred = false
        return vim.b.gitsigns_blame_line or ""
      end,
    },
  },
}

M.base46 = {
  theme = "chadracula",
  theme_toggle = { "chadracula", "one_light" },

  hl_override = highlights.override,
  hl_add = highlights.add,
}

return M
