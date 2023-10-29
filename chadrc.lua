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
  },
  statusline = {
    theme = "default", -- default/vscode/vscode_colored/minimal
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = "default",
    overriden_modules = function(modules)
      -- see https://nvchad.com/docs/config/nvchad_ui#override_statusline_modules

      table.insert(
        modules,
        4,
        (function()
          local git_blame = require "gitblame"
          if git_blame.is_blame_text_available() then
            return git_blame.get_current_blame_text()
          end
          return ""
        end)()
      )
    end,
  },
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
