---@type MappingsTable
local M = {}

M.disabled = {
  n = {

    ["<C-n>"] = "",
    -- In lspconfig
    ["<leader>lf"] = "",
  },
}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<C-h>"] = { "<cmd> nohlsearch <CR>", "turn off highlights" },
    ["<C-A-z>"] = { "<cmd> set wrap! <CR>", "toggle soft wrap" },
  },
  v = {
    ["<C-c>"] = { '"+y', "copy selection to clipboard" },
    ["'"] = { "i'", "copy inner quote shortcut" },
    ['"'] = { 'i"', "copy inner quote shortcut" },
    ["`"] = { "i`", "copy inner quote shortcut" },
    ["]"] = { "i]", "copy inner quote shortcut" },
    ["}"] = { "i}", "copy inner quote shortcut" },
    [")"] = { "i)", "copy inner quote shortcut" },
  },
}

M.nvimtree = {
  plugin = true,

  n = {
    -- toggle
    ["<C-b>"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
  },
}

M.telescope = {
  plugin = true,

  n = {
    ["<C-S-p>"] = { "<cmd> Telescope commands <CR>", "Open commands panel" },
    -- find
    ["<C-p>"] = { "<cmd> Telescope find_files <CR>", "Find files" },
    ["<C-f>"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "Find in current buffer" },
    ["<C-j>"] = { "<cmd> Telescope treesitter <CR>", "Find symbols" },
  },
}

M.tabufline = {
  plugin = true,

  n = {
    -- close buffer + hide terminal buffer
    ["<A-w>"] = {
      function()
        require("nvchad.tabufline").close_buffer()
      end,
      "Close buffer",
    },
  },
}

M.lspconfig = {
  plugin = true,
  n = {
    ["<leader>d"] = {
      function()
        vim.diagnostic.open_float { border = "rounded" }
      end,
      "Floating diagnostic",
    },
  },
}

M.ctrlsf = {
  plugin = true,
  n = {
    ["<C-S-f>"] = { "<Esc> :CtrlSF ", "Begin find in files" },
    ["<leader>tf"] = { "<cmd> CtrlSFToggle <CR>", "Toggle CtrlSF Window" },
  },
}

-- more keybinds!

return M
