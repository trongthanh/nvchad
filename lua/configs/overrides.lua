local M = {}

M.whichkey = {
  triggers = {
    { "<leader>", mode = "nxso" },
    { "<C-w>", mode = "nxso" },
    { "g", mode = "nxso" },
    { "\\\\", mode = "nxso" },
  },
  defer = function(ctx)
    return ctx.mode == "<C-V>"
  end,
}

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

-- noexport
-- local cmp = {
M.cmp = {
  completion = {
    -- delay completion in myinit.lua
    autocomplete = false,
    -- added noselect so that I can <CR> if I don't want to accept any of the suggestions
    completeopt = "menu,menuone,noselect",
  },

  mapping = {
    ["<CR>"] = require("cmp").mapping {
      i = function(fallback)
        local cmp = require "cmp"
        if cmp.visible() and cmp.get_active_entry() then
          cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false }
        else
          fallback()
        end
      end,
      s = require("cmp").mapping.confirm { select = true },
      c = require("cmp").mapping.confirm { behavior = require("cmp").ConfirmBehavior.Replace, select = true },
    },
    -- ["<Down>"] = require("cmp").mapping(function(fallback)
    --   local cmp = require "cmp"
    --   if cmp.visible() then
    --     cmp.select_next_item()
    --   else
    --     fallback()
    --   end
    -- end, { "i" }),
    -- ["<Up>"] = require("cmp").mapping(function(fallback)
    --   local cmp = require "cmp"
    --   if cmp.visible() and cmp.get_active_entry() then
    --     cmp.select_prev_item()
    --   else
    --     fallback()
    --   end
    -- end, { "i" }),
    --
    -- -- disable tab so that copilot will work
    -- ["<Tab>"] = function(callback)
    --   callback()
    -- end,
    --
    -- ["<S-Tab>"] = function(callback)
    --   callback()
    -- end,
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
    path_display = {
      "filename_first",
    },
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
  excluded_buftypes = {
    "terminal",
    "nofile",
  },
  excluded_filetypes = {
    "cmp_docs",
    "cmp_menu",
    "noice",
    "prompt",
    "TelescopePrompt",
    "NVimTree",
  },
  marks = {
    Search = { color = "#ff9e64" },
    Error = { color = "#db4b4b" },
    Warn = { color = "#e0af68" },
    Info = { color = "#0db9d7" },
    Hint = { color = "#1abc9c" },
    Misc = { color = "#9d7cd8" },
    -- these scrollbar marks often hide the last character of wrapped lines
    GitAdd = { text = "" },
    GitChange = { text = "" },
    GitDelete = { text = "" },
  },
}

return M
