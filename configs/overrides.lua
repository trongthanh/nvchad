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
    "tsx",
    "typescript",
    "vim",
    "yaml",
    "go",
    -- "html",
    -- "mermaid"
  },
  -- ignore_install = { "markdown" },

  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
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
    disable = { "mermaid", "html" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
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

    -- go lang
    "gopls",
  },
}

-- git support in nvimtree
M.nvimtree = {
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
      "node_modules",
      "package-lock\\.json",
      "pnpm-lock\\.yaml",
      "yarn\\.lock",
    },
  },
}

M.cmp = {
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
}

M.telescope = {
  defaults = {
    mappings = {
      i = { ["<C-x>"] = require("telescope.actions").close },
      n = { ["q"] = require("telescope.actions").close },
    },
    file_ignore_patterns = { "node_modules", ".git/objects/" },
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
