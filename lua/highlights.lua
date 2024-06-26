-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}

---@type Base46HLGroupsList
M.override = {
  ["@comment"] = {
    italic = true,
  },
  Comment = {
    italic = true,
  },
  Normal = {
    -- darken background
    bg = { "black", -3 },
  },
  -- nvimtree
  NvimTreeOpenedFolderName = { bold = true },
  NvimTreeGitDirty = { fg = "yellow" },
  NvimTreeGitNew = { fg = "green" },
  NvimTreeSpecialFile = { fg = "cyan" },
}

--- @type HLTable
--- For new highlight groups not in NvChad/base46 repo
M.add = {}

return M
