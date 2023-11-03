local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = overrides.telescope,
  },
  {

    "hrsh7th/nvim-cmp",
    opts = overrides.cmp,
  },
  -- load git related plugin
  {
    "lewis6991/gitsigns.nvim",
    opts = overrides.gitsigns,
  },
  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  {
    "mg979/vim-visual-multi",
    lazy = false,
  },
  -- better editorconfig
  {
    "gpanders/editorconfig.nvim",
    lazy = false,
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
    config = function()
      vim.g.ctrlsf_auto_focus = { at = "start" }
      vim.g.ctrlsf_position = "right_local"
    end,
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
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "dyng/ctrlsf.vim",
    lazy = false,
    init = function()
      require("core.utils").load_mappings "ctrlsf"
    end,
  },
  {
    "godlygeek/tabular",
    lazy = false,
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    config = function()
      require("core.utils").load_mappings "markdownpreview"
    end,
  },
  {
    "mattn/emmet-vim",
    ft = { "html", "xml" },
  },
  {
    "mracos/mermaid.vim",
    ft = { "mermaid", "markdown" },
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
      require("core.utils").load_mappings "copilot"
    end,
  },
  {
    "ggandor/leap.nvim",
    init = function()
      require("leap").add_default_mappings()
    end,
  },
}

return plugins
