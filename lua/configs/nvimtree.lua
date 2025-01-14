local augroup = vim.api.nvim_create_augroup("nvimtree", {})
-- Auto commands
local autocmd = vim.api.nvim_create_autocmd

-- force NvimTree window to normal mode
autocmd("BufEnter", {
  group = augroup,
  pattern = "NvimTree*",
  command = "stopinsert",
})

-- extra action for nvimtree
local git_add = function()
  local api = require "nvim-tree.api"
  local node = api.tree.get_node_under_cursor()
  local gs = node.git_status.file

  -- If the current node is a directory get children status
  if gs == nil then
    gs = (node.git_status.dir.direct ~= nil and node.git_status.dir.direct[1])
      or (node.git_status.dir.indirect ~= nil and node.git_status.dir.indirect[1])
  end

  -- If the file is untracked, unstaged or partially staged, we stage it
  if gs == "??" or gs == "MM" or gs == "AM" or gs == " M" then
    vim.cmd("silent !git add " .. node.absolute_path)

  -- If the file is staged, we unstage
  elseif gs == "M " or gs == "A " then
    vim.cmd("silent !git restore --staged " .. node.absolute_path)
  end

  api.tree.reload()
end

local on_nvimtree_attach = function(bufnr)
  local api = require "nvim-tree.api"
  -- default mappings
  api.config.mappings.default_on_attach(bufnr)
  -- custom mappings centralized in mappings.lua
  require("mappings").nvimtree(bufnr, api, { git_add = git_add })
end
-- git support in nvimtree
local options = {
  on_attach = on_nvimtree_attach,
  view = {
    width = {
      min = 25,
      max = "20%",
      padding = 1,
    },
    side = "right",
  },
  git = {
    enable = true,
    ignore = false,
    show_on_dirs = true,
    timeout = 200,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
  filters = {
    dotfiles = false,
    custom = {
      "\\.DS_Store",
      "\\.cache",
      "\\.git$",
      "\\.linaria-cache",
      "\\.sass-cache",
      "__coverage__",
      "__pycache__",
      "node_modules",
      "package-lock\\.json",
      "pnpm-lock\\.yaml",
      "yarn\\.lock",
    },
  },
}

return {
  opts = options,
}
