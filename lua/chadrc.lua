-- Path to overriding theme and highlights files
local blame_deferred = false

---@type ChadrcConfig
local options = {

  ui = {
    statusline = {
      theme = "vscode_colored", -- default/vscode/vscode_colored/minimal
      -- default/round/block/arrow separators work only for default statusline theme
      -- round and block will work for minimal theme only
      separator_style = "default",
      order = { "mode", "file", "git", "blame", "obsidian", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "loc" }, -- "cwd", "cursor",
      modules = {
        -- see https://nvchad.com/docs/config/nvchad_ui#override_statusline_modules
        -- display line & column number
        loc = "%#St_pos_sep#%#St_pos_icon# %l:%c ",
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

        obsidian = function()
          if vim.g.obsidian ~= nil then
            return " 🪨 " .. vim.g.obsidian
          end
          return ""
        end,
      },
    },
    tabufline = {
      enabled = true,
      lazyload = true,
      order = { "treeOffset", "buffers", "tabs", "btns" },
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

      {
        txt = function()
          local path = vim.fn.getcwd()
          if #path > 58 then
            return " ..." .. string.sub(path, -55)
          end
          return " " .. path
        end,
        hl = "NvDashLazy",
        no_gap = true,
      },
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

    hl_override = {
      {
        italic = true,
      },
      Comment = {
        italic = true,
      },
      Normal = {
        -- darken background
        bg = { "black", -3 },
      },
      Visual = {
        -- make visual selection more readable at comments
        bg = { "one_bg2", -3 },
      },
      -- nvimtree
      NvimTreeOpenedFolderName = { bold = true },
      NvimTreeGitDirty = { fg = "yellow" },
      NvimTreeGitNew = { fg = "green" },
      NvimTreeSpecialFile = { fg = "cyan" },
      -- markdown
      ["@markup.heading"] = { bold = true },
    },
    hl_add = {},
  },
}

return options
