local M = {}

M.treesitter = {
  ensure_installed = {
    "bash",
    "css",
    "dockerfile",
    "gitignore",
    "javascript",
    "jsdoc",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
    "styled",
    "tsx",
    "typescript",
    "vim",
    "yaml",
    "go",
    "vue",
    "twig", -- for twig and nunjucks templates
    "html",
    -- "mermaid"
  },
  -- ignore_install = { "markdown" },

  indent = {
    enable = true,
    disable = {
      "markdown",
      "markdown_inline",
    },
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "+",
      node_incremental = "+",
      scope_incremental = ")",
      node_decremental = "_",
    },
  },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "html" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = { "markdown" },
  },
}

M.gitsigns = {
  current_line_blame = true,
  current_line_blame_opts = {
    -- we use statusline
    virt_text = true,
    delay = 100,
    virt_text_pos = "right_align",
  },
  current_line_blame_formatter = " <author>, <author_time:%R>",
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
