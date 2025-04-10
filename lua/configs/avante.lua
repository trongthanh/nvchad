local avante_config = {
  windows = {
    position = "left",
    width = 30,
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
  provider = "orclaude",
  behaviour = {
    enable_cursor_planning_mode = false,
    -- enable_claude_text_editor_tool_mode = true,
  },
  vendors = {
    copilotclaude = {
      __inherited_from = "copilot",
      api_key_name = "GITHUB_TOKEN",
      model = "claude-3.7-sonnet",
      max_tokens = 8192,
    },
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
  },
}

return avante_config
