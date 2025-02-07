-- treesitter config
local desc = function(str)
  return "treesitter " .. str
end

local treesitterconfig = {
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
    -- disable = { "html" },
    -- disable for large file
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    -- additional_vim_regex_highlighting = { "markdown" },
  },
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = { query = "@function.outer", desc = "TextObject Outer function" },
        ["if"] = { query = "@function.inner", desc = "TextObject Inner function" },
        ["ac"] = { query = "@class.outer", desc = "TextObject Outer class" },
        ["ic"] = { query = "@class.inner", desc = "TextObject Inner class" },

        ["a="] = { query = "@assignment.outer", desc = "TextObject Outer part of an assignment" },
        ["i="] = { query = "@assignment.inner", desc = "TextObject Inner part of an assignment" },
        ["l="] = { query = "@assignment.lhs", desc = "TextObject Left hand side of an assignment" },
        ["r="] = { query = "@assignment.rhs", desc = "TextObject Right hand side of an assignment" },

        ["aa"] = { query = "@parameter.outer", desc = "TextObject Outer part of a parameter/argument" },
        ["ia"] = { query = "@parameter.inner", desc = "TextObject Inner part of a parameter/argument" },
        ["a9"] = { query = "@call.outer", desc = "TextObject Outer part of a function call" }, -- 9 is unshift of (
        ["i9"] = { query = "@call.inner", desc = "TextObject Inner part of a function call" },
        ["a0"] = { query = "@call.outer", desc = "TextObject Outer part of a function call" }, -- 0 is unshift of )
        ["i0"] = { query = "@call.inner", desc = "TextObject Inner part of a function call" },

        ["a/"] = { query = "@comment.outer", desc = "TextObject Outer comment" },
        ["i/"] = { query = "@comment.inner", desc = "TextObject Inner comment" },

        -- You can also use captures from other query groups like `locals.scm`
        ["as"] = { query = "@scope", query_group = "locals", desc = "TextObject Select language scope" },
      },
      -- You can choose the select mode (default is charwise 'v')
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * method: eg 'v' or 'o'
      -- and should return the mode ('v', 'V', or '<c-v>') or a table
      -- mapping query_strings to modes.
      -- selection_modes = {
      --   ["@parameter.outer"] = "v", -- charwise
      --   ["@function.outer"] = "V", -- linewise
      --   ["@class.outer"] = "<c-v>", -- blockwise
      -- },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding or succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * selection_mode: eg 'v'
      -- and should return true or false
      include_surrounding_whitespace = false,
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]f"] = { query = "@function.outer", desc = "treesitter Next function start" },
        ["]c"] = { query = "@class.outer", desc = "treesitter Next class start" },
        --
        -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
        ["]l"] = { query = "@loop.*", desc = "treesitter Next loop" },
        -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
        --
        -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
        -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
        ["]s"] = { query = "@scope", query_group = "locals", desc = "treesitter Next scope" },
        ["]z"] = { query = "@fold", query_group = "folds", desc = "treesitter Next fold" },
      },
      goto_next_end = {
        ["]F"] = { query = "@function.outer", desc = "treesitter Next function end" },
        ["]C"] = { query = "@class.outer", desc = "treesitter Next class end" },
      },
      goto_previous_start = {
        ["[f"] = { query = "@function.outer", desc = "treesitter Previous function start" },
        ["[c"] = { query = "@class.outer", desc = "treesitter Previous class start" },
      },
      goto_previous_end = {
        ["[F"] = { query = "@function.outer", desc = "treesitter Previous function end" },
        ["[C"] = { query = "@class.outer", desc = "treesitter Previous class end" },
      },
      -- Below will go to either the start or the end, whichever is closer.
      -- Use if you want more granular movements
      -- Make it even more gradual by adding multiple queries and regex.
      goto_next = {
        ["]i"] = { query = "@conditional.outer", desc = "treesitter Next condition start" },
      },
      goto_previous = {
        ["[i"] = { query = "@conditional.outer", desc = "treesitter Previous condition start" },
      },
    },
  },
}

return treesitterconfig
