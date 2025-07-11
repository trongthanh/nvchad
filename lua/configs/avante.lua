local avante_config = {
  windows = {
    position = "left",
    width = 30,
    input = {
      prefix = "> ",
      height = 5, -- Height of the input window in vertical layout
    },
    ask = {
      focus_on_apply = "theirs",
    },
  },
  mappings = {
    sidebar = {
      close = { "q" },
    },
  },
  repo_map = {
    ignore_patterns = { "%.git", "%.worktree", "__pycache__", "node_modules", "NvimTree_1" }, -- ignore files matching these
  },
  -- The system_prompt type supports both a string and a function that returns a string. Using a function here allows dynamically updating the prompt with mcphub
  system_prompt = function()
    local hub = require("mcphub").get_hub_instance()
    return hub:get_active_servers_prompt()
  end,
  -- The custom_tools type supports both a list and a function that returns a list. Using a function here prevents requiring mcphub before it's loaded
  custom_tools = function()
    return {
      require("mcphub.extensions.avante").mcp_tool(),
    }
  end,
  -- Disable any built-in Avante tools that might conflict with builtin mcphub mcp servers
  disabled_tools = {
    "list_files",
    "search_files",
    "read_file",
    "create_file",
    "rename_file",
    "delete_file",
    "create_dir",
    "rename_dir",
    "delete_dir",
    "bash",
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
  -- auto_suggestions_provider = "copilot",
  -- provider = "opengemini",
  -- provider = "copilotclaude",
  provider = "copilot",
  behaviour = {
    enable_cursor_planning_mode = false,
    -- enable_claude_text_editor_tool_mode = true,
  },
  cursor_applying_provider = "geminiflash",
  copilot = {
    model = "claude-3.5-sonnet",
  },
  vendors = {
    geminiflash = {
      __inherited_from = "gemini",
      api_key_name = "GEMINI_API_KEY",
      model = "gemini-2.0-flash-exp",
    },
    ordeepseek = {
      __inherited_from = "openai",
      api_key_name = "OPENROUTER_API_KEY",
      endpoint = "https://openrouter.ai/api/v1",
      model = "deepseek/deepseek-r1",
    },
    orclaude = {
      __inherited_from = "openai",
      api_key_name = "OPENROUTER_API_KEY",
      endpoint = "https://openrouter.ai/api/v1",
      model = "anthropic/claude-3.7-sonnet",
    },
    orquasaralpha = {
      __inherited_from = "openai",
      api_key_name = "OPENROUTER_API_KEY",
      endpoint = "https://openrouter.ai/api/v1",
      model = "openrouter/quasar-alpha",
    },
    qwen = {
      __inherited_from = "openai",
      api_key_name = "OPENROUTER_API_KEY",
      endpoint = "https://openrouter.ai/api/v1",
      model = "qwen/qwen-2.5-coder-32b-instruct",
      max_tokens = 8192,
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
