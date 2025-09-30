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
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      dashboard = { enabled = false },
      explorer = { enabled = false },
      indent = { enabled = false },
      input = { enabled = true },
      picker = { enabled = false },
      notifier = { enabled = true, timeout = 5000, top_down = false },
      quickfile = { enabled = true },
      scope = { enabled = false },
      scroll = { enabled = true },
      statuscolumn = { enabled = false },
      words = { enabled = false },
      image = {
        enabled = true,
        resolve = function(path, src)
          if require("obsidian.api").path_is_note(path) then
            return require("obsidian.api").resolve_image_path(src)
          end
        end,
      },
    },
    keys = {
        {"<leader>nh",  function() require('snacks').notifier.show_history() end, desc = "Notification History" },
    }
  },
  {
    "hrsh7th/nvim-cmp",
    opts = overrides.cmp,
    dependencies = {
      "f3fora/cmp-spell",
    },
  },
  -- {
  --   "saghen/blink.cmp",
  --   dependencies = {
  --     "Kaiser-Yang/blink-cmp-avante",
  --     "rafamadriz/friendly-snippets",
  --   },
  --   opts = {
  --     keymap = {
  --       ["<S-Tab>"] = { "select_prev", "fallback" },
  --       ["<Tab>"] = { "select_next", "fallback" },
  --     },
  --
  --     completion = {
  --       -- Don't preselectt by default, auto insert on selection
  --       list = { selection = { preselect = false, auto_insert = true } },
  --     },
  --     sources = {
  --       -- Add 'avante' to the list
  --       default = { "avante", "lsp", "path", "snippets", "buffer" },
  --       providers = {
  --         avante = {
  --           module = "blink-cmp-avante",
  --           name = "Avante",
  --         },
  --       },
  --     },
  --   },
  -- },
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
    "kevinhwang91/nvim-ufo",
    event = "VeryLazy",
    dependencies = { "kevinhwang91/promise-async" },
    opts = {},
    init = function()
      vim.o.fillchars = [[eob: ,fold: ,foldopen:▾,foldsep: ,foldclose:▸]]
      vim.o.foldcolumn = "0" -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = require "configs.nvimtree",
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
    "davidmh/mdx.nvim",
    event = "BufEnter *.mdx",
    opts = {},
    dependencies = { "nvim-treesitter/nvim-treesitter" },
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
    "zbirenbaum/copilot.lua",
    -- lazy = false,
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      copilot_node_command = "/opt/homebrew/bin/node",
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true,
        debounce = 200,
        trigger_on_accept = true,
        keymap = {
          accept = "<M-space>",
          accept_word = "<M-right>",
          accept_line = false,
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit

    event = {
      "BufReadPre " .. vim.fn.expand "~" .. "/Sync/wiki/**.md",
      "BufNewFile " .. vim.fn.expand "~" .. "/Sync/wiki/**.md",
    },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "hrsh7th/nvim-cmp",
    },
    keys = require("mappings").obsidian,
    opts = require "configs.obsidian",
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- set this if you want to always pull the latest change
    opts = require "configs.avante",
    keys = require("mappings").avante,
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      -- "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "nvim-telescope/telescope.nvim",
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        "ravitemer/mcphub.nvim",
        dependencies = {
          "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
        },
        -- uncomment the following line to load hub lazily
        --cmd = "MCPHub",  -- lazy load
        -- build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
        -- uncomment this if you don't want mcp-hub to be available globally or can't use -g
        build = "bundled_build.lua", -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
        opts = {
          use_bundled_binary = true,
          -- for use with Avante
          auto_approve = true,
        },
      },
      -- {
      --   -- Make sure to set this up properly if you have lazy=true
      --   "MeanderingProgrammer/render-markdown.nvim",
      --   opts = {
      --     file_types = { "markdown", "Avante" },
      --   },
      --   ft = { "markdown", "Avante" },
      -- },
    },
  },

  {
    "varnishcache-friends/vim-varnish",
    ft = { "vcl" },
  },
}

return plugins
