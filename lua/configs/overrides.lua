local M = {}

M.gitsigns = {
  current_line_blame = true,
  current_line_blame_opts = {
    -- we use statusline
    virt_text = false,
    delay = 0,
    virt_text_pos = "right_align",
  },
  current_line_blame_formatter = "  <author>, <author_time:%R>",
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    require("mappings").gitsigns(bufnr, gs)
  end,
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "eslint-lsp",
    "html-lsp",
    "json-lsp",
    "prettierd",
    "typescript-language-server",
    "stylelint-lsp",
    "tailwindcss-language-server",
    "vue-language-server",

    -- go lang
    "gopls",

    -- python
    -- "python-lsp-server",
    "pyright",
    "black", -- python formatter
    -- yaml
    "yaml-language-server",
  },
}

M.cmp = {
  completion = {
    -- added noselect so that I can <CR> if I don't want to accept any of the suggestions
    completeopt = "menu,menuone,noselect",
  },

  mapping = {
    ["<CR>"] = require("cmp").mapping.confirm {
      behavior = require("cmp").ConfirmBehavior.Insert,
      select = false,
    },
    ["<Down>"] = require("cmp").mapping(function(fallback)
      if require("cmp").visible() then
        require("cmp").select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<Up>"] = require("cmp").mapping(function(fallback)
      if require("cmp").visible() then
        require("cmp").select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),

    -- disable tab so that copilot will work
    ["<Tab>"] = function(callback)
      callback()
    end,

    ["<S-Tab>"] = function(callback)
      callback()
    end,
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "nvim_lua" },
    { name = "path" },
    {
      name = "spell",
      option = {
        keep_all_entries = false,
        enable_in_context = function()
          return true
        end,
      },
    },
  },
}

M.telescope = {
  defaults = {
    mappings = {
      i = { ["<Esc>"] = require("telescope.actions").close },
      n = {
        ["q"] = require("telescope.actions").close,
        ["<Esc>"] = require("telescope.actions").close,
      },
    },
    file_ignore_patterns = { "node_modules", "%.git/objects", "%.git/refs", "%.git/logs", "%.venv" },
  },
}

M.scrollbar = {
  marks = {
    Search = { color = "#ff9e64" },
    Error = { color = "#db4b4b" },
    Warn = { color = "#e0af68" },
    Info = { color = "#0db9d7" },
    Hint = { color = "#1abc9c" },
    Misc = { color = "#9d7cd8" },
  },
}

return M
