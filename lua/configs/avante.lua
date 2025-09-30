local avante_config = {
  windows = {
    position = "right",
    width = 33,
    input = {
      prefix = "> ",
      height = 10, -- Height of the input window in vertical layout
    },
    ask = {
      focus_on_apply = "theirs",
    },
  },
  mappings = {
    cancel = {
      normal = { "<C-c>", "<Esc>", "q" },
      insert = { "<C-c>" },
    },
    sidebar = {
      close = { "<M-w>" },
    },
  },
  spinner = {
    -- stylua: ignore
    generating = { "·", "·", "✢", "✢", "✳", "✳", "✲", "✲", "✻", "✻", "✽", "✽", "✽" }, -- Spinner characters for the 'generating' state
    thinking = { "🤯", "🤔" }, -- Spinner characters for the 'thinking' state
  },
  repo_map = {
    ignore_patterns = { "%.git", "%.worktree", "__pycache__", "node_modules", "NvimTree_1" }, -- ignore files matching these
  },
  -- system_prompt as function ensures LLM always has latest MCP server state
  -- This is evaluated for every message, even in existing chats
  system_prompt = function()
    local hub = require("mcphub").get_hub_instance()
    return hub and hub:get_active_servers_prompt() or ""
  end,
  -- Using function prevents requiring mcphub before it's loaded
  custom_tools = function()
    return {
      require("mcphub.extensions.avante").mcp_tool(),
    }
  end,
  -- Disable any built-in Avante tools that might conflict with builtin mcphub mcp servers
  disabled_tools = {
    -- "list_files",
    -- "search_files",
    -- "read_file",
    -- "create_file",
    -- "rename_file",
    -- "delete_file",
    -- "create_dir",
    -- "rename_dir",
    -- "delete_dir",
    -- "bash",
  },
  selector = {
    --- @alias avante.SelectorProvider "native" | "fzf_lua" | "mini_pick" | "snacks" | "telescope" | fun(selector: avante.ui.Selector): nil
    provider = "telescope",
  },
  file_selector = {
    --- @alias FileSelectorProvider "native" | "fzf" | "mini.pick" | "telescope" | string
    provider = "telescope",
    -- Options override for custom providers
    provider_opts = {
      get_filepaths = function(params)
        local cwd = params.cwd ---@type string
        local selected_filepaths = params.selected_filepaths ---@type string[]
        local cmd = string.format("fd --base-directory '%s' --hidden --exclude .git/", vim.fn.fnameescape(cwd))
        local output = vim.fn.system(cmd)
        local filepaths = vim.split(output, "\n", { trimempty = true })
        return vim
          .iter(filepaths)
          :filter(function(filepath)
            return not vim.tbl_contains(selected_filepaths, filepath)
          end)
          :totable()
      end,
    },
  },
  -- provider = "claude-code",
  -- acp_providers = {
  --   ["gemini-cli"] = {
  --     command = "gemini",
  --     args = { "--experimental-acp" },
  --     env = {
  --       NODE_NO_WARNINGS = "1",
  --     },
  --   },
  --   ["claude-code"] = {
  --     command = "npx",
  --     args = { "@zed-industries/claude-code-acp" },
  --     env = {
  --       NODE_NO_WARNINGS = "1",
  --       HTTP_PROXY = "http://127.0.0.1",
  --     },
  --   },
  -- },

  ---@alias Mode "agentic" | "legacy"
  ---@type Mode
  mode = "agentic",
  -- auto_suggestions_provider = "copilot",
  provider = "orgrokcodefast1",
  behaviour = {
    auto_approve_tool_permissions = false,
    -- enable_claude_text_editor_tool_mode = true,
  },
  providers = {
    geminiflash = {
      __inherited_from = "openai",
      api_key_name = "OPENROUTER_API_KEY",
      endpoint = "https://openrouter.ai/api/v1",
      model = "google/gemini-2.5-flash",
    },
    orkimik2 = {
      __inherited_from = "openai",
      api_key_name = "OPENROUTER_API_KEY",
      endpoint = "https://openrouter.ai/api/v1",
      model = "moonshotai/kimi-k2",
    },
    ordeepseekr1 = {
      __inherited_from = "openai",
      api_key_name = "OPENROUTER_API_KEY",
      endpoint = "https://openrouter.ai/api/v1",
      model = "deepseek/deepseek-r1-0528",
    },
    orqwen3coder = {
      __inherited_from = "openai",
      api_key_name = "OPENROUTER_API_KEY",
      endpoint = "https://openrouter.ai/api/v1",
      model = "qwen/qwen3-coder-plus",
    },
    orclaude = {
      __inherited_from = "openai",
      api_key_name = "OPENROUTER_API_KEY",
      endpoint = "https://openrouter.ai/api/v1",
      model = "anthropic/claude-sonnet-4",
    },
    orgrokcodefast1 = {
      __inherited_from = "openai",
      api_key_name = "OPENROUTER_API_KEY",
      endpoint = "https://openrouter.ai/api/v1",
      model = "x-ai/grok-code-fast-1",
    },
    qwen3coder = {
      __inherited_from = "openai",
      api_key_name = "ALIYUN_API_KEY",
      endpoint = "https://dashscope-intl.aliyuncs.com/compatible-mode/v1/",
      model = "qwen3-coder-plus",
    },
    ollama = {
      __inherited_from = "openai",
      api_key_name = "",
      endpoint = "http://127.0.0.1:11434/v1",
      model = "qwen2.5-coder",
    },
  },
}

return avante_config
