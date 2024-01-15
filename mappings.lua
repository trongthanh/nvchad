---@type MappingsTable
local M = {}

M.disabled = {
  n = {
    -- reserve this shortcut for vim-visual-multi
    ["<C-n>"] = "",
    ["<leader>n"] = "", -- changed to <leader>nn
    ["<leader>rn"] = "", -- changed to <leader>nr
    -- telescope
    ["<leader>cm"] = "", -- changed to <leader>gc
    ["<leader>ma"] = "", -- changed to <leader>tm
    -- Change lspconfig shortcuts to <leader>l*
    ["<leader>q"] = "",
    ["<leader>fm"] = "",
    ["<leader>ca"] = "",
    ["<leader>ra"] = "",
    ["<leader>rh"] = "", -- changed to hr
    ["<leader>ph"] = "", -- changed to hp
  },
}

M.general = {
  i = {
    ["<C-A-t>"] = { "<C-r>=strftime('%FT%T%z')<CR>", "Insert ISO Time string" },
  },
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<C-A-z>"] = { "<cmd> set wrap! <CR>", "toggle soft wrap" },
    ["<leader>q"] = { "<C-w>q", "Close (split) window" },
    ["<C-A-f>"] = { ":%s/", "Search and replace prompt" },
    ["<leader>nn"] = { "<cmd> set nu! <CR>", "Toggle line number" },
    ["<leader>nr"] = { "<cmd> set rnu! <CR>", "Toggle relative number" },
    ["<C-A-t>"] = { '"=strftime("%FT%T%z")<CR>P', "Insert ISO Time string" },
    ["<C-S-a>"] = { "ggVG", "Select all" },
    ["<leader>wji"] = { ":WikiJournalIndex<CR>", "Insert Journal Index" },
    ["<leader>X"] = {
      function()
        require("nvchad.tabufline").closeAllBufs()
      end,
      "Close all (unedited) buffers",
    },
  },
  v = {
    ["<C-f>"] = { 'y<ESC>/<c-r>"<CR>', "Search current selection" },
    ["<C-h>"] = { ":s/\\%V", "Start search and replace within selection" },
    ["<C-c>"] = { '"+y', "copy selection to clipboard" },
    ["'"] = { "i'", "select inner quotes shortcut" },
    ['"'] = { 'i"', "select inner quotes shortcut" },
    ["`"] = { "i`", "select inner quotes shortcut" },
    ["]"] = { "i]", "select inner brackets shortcut" },
    ["}"] = { "i}", "select inner brackets shortcut" },
    [")"] = { "i)", "select inner brackets shortcut" },
  },
  x = {
    ["il"] = { "g_o^", "line object", opts = { silent = true } },
    ["al"] = { "$o0", "line object", opts = { silent = true } },
  },
  o = {
    ["il"] = { ":<c-u>normal! g_v^<cr>", "inner line object", opts = { silent = true } },
    ["al"] = { ":<c-u>normal! $v0<cr>", "outer line object", opts = { silent = true } },
    ['"'] = { ':<c-u>normal! vi"<cr>', "inner quote object", opts = { silent = true } },
    ["'"] = { ":<c-u>normal! vi'<cr>", "inner quote object", opts = { silent = true } },
    ["`"] = { ":<c-u>normal! vi`<cr>", "inner quote object", opts = { silent = true } },
    ["]"] = { ":<c-u>normal! vi]<cr>", "inner brackets object", opts = { silent = true } },
    ["}"] = { ":<c-u>normal! vi}<cr>", "inner brackets object", opts = { silent = true } },
    [")"] = { ":<c-u>normal! vi)<cr>", "inner brackets object", opts = { silent = true } },
  },
}

M.nvimtree = {
  plugin = true,

  n = {
    -- toggle
    ["<C-b>"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
    ["ga"] = {
      function()
        require("custom.configs.nvimtree").git_add()
      end,
      "nvim-tree: Git Add",
    },
  },
}

M.telescope = {
  plugin = true,

  n = {
    ["<C-S-p>"] = { "<cmd> Telescope commands <CR>", "Open commands panel" },
    -- find
    ["<C-p>"] = { "<cmd> Telescope find_files hidden=true <CR>", "Find files" },
    ["<C-f>"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "Find in current buffer" },
    ["<C-j>"] = { "<cmd> Telescope treesitter <CR>", "Find symbols" },

    ["<leader>gc"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
    ["<leader>tm"] = { "<cmd> Telescope marks <CR>", "telescope bookmarks" },
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
    ["<leader>lf"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "LSP formatting",
    },
    ["<leader>ll"] = {
      function()
        vim.diagnostic.setloclist()
      end,
      "Diagnostic setloclist",
    },
    ["<leader>r"] = {
      function()
        require("nvchad.renamer").open()
      end,
      "LSP rename",
    },

    ["<leader>a"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
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

M.markdownpreview = {
  plugin = true,
  n = {
    ["<leader>pm"] = { "<cmd> MarkdownPreview <CR>", "Preview Markdown" },
  },
}

M.gitsigns = {
  plugin = true,
  n = {
    ["<leader>hr"] = {
      function()
        require("gitsigns").reset_hunk()
      end,
      "Reset hunk",
    },

    ["<leader>hp"] = {
      function()
        require("gitsigns").preview_hunk()
      end,
      "Preview hunk",
    },
  },
}

M.copilot = {
  plugin = true,
  i = {
    ["<C-Space>"] = {
      function()
        vim.fn.feedkeys(vim.fn["copilot#Accept"](), "")
      end,
      "Copilot Accept",
      { replace_keycodes = true, nowait = true, silent = true, expr = true, noremap = true },
    },
  },
}

-- more keybinds!

return M
