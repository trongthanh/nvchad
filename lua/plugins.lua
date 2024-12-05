local overrides = require "configs.overrides"

---@type NvPluginSpec[]
local plugins = {
  {
    -- Override nvchad's to remove `v` `c` key
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-w>", '"', "'", "`", "g" },
    cmd = "WhichKey",
    opts = function()
      dofile(vim.g.base46_cache .. "whichkey")
      return overrides.whichkey
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },
  {
    "stevearc/conform.nvim",
    -- for users those who want auto-save conform + lazyloading!
    event = { "BufWritePre" },
    config = function()
      require "configs.conform"
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = overrides.telescope,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = overrides.cmp,
    dependencies = {
      { "f3fora/cmp-spell" },
    },
  },
  {
    "petertriho/nvim-scrollbar",
    lazy = false,
    opts = overrides.scrollbar,
  },
  -- load git related plugin
  {
    "lewis6991/gitsigns.nvim",
    opts = overrides.gitsigns,
    dependencies = {
      -- not related, but make use of the gitsigns lazy loading
      {
        "sindrets/diffview.nvim",
        -- lazy = false,
      },
    },

    config = function(_, opts)
      dofile(vim.g.base46_cache .. "git")
      require("gitsigns").setup(opts)
      require("scrollbar.handlers.gitsigns").setup()
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = require "configs.treesitter",
    init = function()
      -- use twig parser for nunjucks until native nunjucks parser is available
      vim.treesitter.language.register("twig", "nunjucks")
      vim.treesitter.language.register("glimmer", "handlebars")
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = require("configs.nvimtree").opts,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "mfussenegger/nvim-dap",
    },
  },
  {
    "mfussenegger/nvim-dap-python",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    -- config = function()
    -- customize debugpy location
    -- require("dap-python").setup ".venv/bin/python"
    -- end,
  },
  -- To make a plugin not be loaded
  {
    "NvChad/nvim-colorizer.lua",
    enabled = true,
  },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  {
    "mg979/vim-visual-multi",
    event = "BufEnter",
  },
  -- surround text ysiw" cs'` ysiw)
  {
    "tpope/vim-surround",
    lazy = false,
  },
  -- move line text <A-hjkl>
  {
    "matze/vim-move",
    lazy = false,
  },
  {
    "windwp/nvim-ts-autotag",
    ft = {
      "html",
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      "svelte",
      "vue",
      "tsx",
      "jsx",
      "rescript",
      "xml",
      "php",
      "markdown",
      "astro",
      "glimmer",
      "handlebars",
      "hbs",
    },
    opts = {},
  },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
  },
  {
    "dyng/ctrlsf.vim",
    lazy = false,
    init = function()
      vim.g.ctrlsf_auto_focus = { at = "start" }
      vim.g.ctrlsf_position = "right_local"
    end,
  },
  {
    "godlygeek/tabular",
    lazy = false,
  },
  {
    "chentoast/marks.nvim",
    lazy = false,
    opts = {},
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
  },
  {
    "mattn/emmet-vim",
    ft = { "html", "xml" },
  },
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {}, -- must provide empty opts to enable lazy loading
  },
  {
    "github/copilot.vim",
    lazy = false,
    init = function()
      -- vim.g.copilot_node_command = "/usr/local/bin/node"
      -- Mapping tab is already used by NvChad
      -- vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      -- vim.g.copilot_tab_fallback = ""
      -- The mapping is set to other key, see custom/lua/mappings
      -- or run <leader>ch to see copilot mapping section
    end,
    config = function()
      require("mappings").copilot()
    end,
  },
  {
    "ggandor/leap.nvim",
    init = function()
      require("leap").add_default_mappings()
    end,
  },
  {
    "SidOfc/mkdx",
    ft = { "markdown", "mermaid" },
    init = function()
      vim.g["mkdx#settings"] = { insert_indent_mappings = 1, tab = { enable = 0 } }
    end,
  },
  {
    "lervag/wiki.vim",
    ft = { "markdown" },
    lazy = false,
    init = function()
      vim.g.wiki_root = "~/Sync/wiki"
      vim.g.wiki_mappings_local_journal = {
        ["<plug>(wiki-journal-prev)"] = "[w",
        ["<plug>(wiki-journal-next)"] = "]w",
      }
    end,
  },
  {
    enabled = false,
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup()
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
}

return plugins
