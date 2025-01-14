-- Path to overriding theme and highlights files
local highlights = require "highlights"
local blame_deferred = false

---@type ChadrcConfig
local options = {

  ui = {
    statusline = {
      theme = "default", -- default/vscode/vscode_colored/minimal
      -- default/round/block/arrow separators work only for default statusline theme
      -- round and block will work for minimal theme only
      separator_style = "default",
      order = { "mode", "file", "git", "blame", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "loc" }, -- "cwd", "cursor",
      modules = {
        -- see https://nvchad.com/docs/config/nvchad_ui#override_statusline_modules
        -- display line & column number
        loc = "%#St_pos_sep#%#St_pos_icon# %l:%c",
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
  },
  nvdash = {
    load_on_startup = false,
    header = {
      "       TRONGTHANH NVIM IDE        ",
      "       Based on NvChad 2.5        ",
      "   github.com/trongthanh/nvchad   ",
      "                                  ",
    },
    buttons = {
      { txt = "  Find File", keys = "Ctrl-p", cmd = "Telescope find_files" },
      { txt = "󰙅  File explorer", keys = "Ctrl-b", cmd = "NvimTreeToggle" },
      { txt = "󰈚  Recent Files", keys = "Spc f o", cmd = "Telescope oldfiles" },
      { txt = "󰈭  Find Word", keys = "Spc f w", cmd = "Telescope live_grep" },
      { txt = "  Bookmarks", keys = "Spc m a", cmd = "Telescope marks" },
      { txt = "  Themes", keys = "Spc t h", cmd = "Telescope themes" },
      { txt = "  Mappings", keys = "Spc c h", cmd = "NvCheatsheet" },
      { txt = "─", hl = "NvDashLazy", no_gap = true, rep = true },

      {
        txt = function()
          local stats = require("lazy").stats()
          local ms = math.floor(stats.startuptime) .. " ms"
          return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
        end,
        hl = "NvDashLazy",
        no_gap = true,
      },

      { txt = "─", hl = "NvDashLazy", no_gap = true, rep = true },
    },
  },

  base46 = {
    theme = "chadracula",
    theme_toggle = { "chadracula", "one_light" },

    hl_override = highlights.override,
    hl_add = highlights.add,
  },
}

return options
