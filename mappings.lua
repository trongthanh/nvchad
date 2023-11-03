---@type MappingsTable
local M = {}

M.disabled = {
  n = {
    -- reserve this shortcut for vim-visual-multi
    ["<C-n>"] = "",
    -- In lspconfig
    ["<leader>fm"] = "",
  },
}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<C-A-z>"] = { "<cmd> set wrap! <CR>", "toggle soft wrap" },
    ["<C-a>"] = { "ggVG", "Select all" },
    ["<leader>q"] = { "<C-w>q", "Close (split) window" },
    ["<C-A-f>"] = { ":%s/", "Search prompt" },
  },
  v = {
    ["<C-f>"] = { 'y<ESC>/<c-r>"<CR>', "Search selected text" },
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
