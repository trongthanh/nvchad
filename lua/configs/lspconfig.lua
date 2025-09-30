-- Load upstream defaults
require("nvchad.configs.lspconfig").defaults()

---

local nvchad_on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local on_attach = function(client, bufnr)
  nvchad_on_attach(client, bufnr)
  -- custom mappings
  require("mappings").lspconfig(client, bufnr)
end

-- if you just want default config for the servers then put them in a table
local servers = {
  "html",
  "cssls",
  "eslint",
  "ts_ls",
  "stylelint_lsp",
  "jsonls",
  "gopls",
  "svelte",
  "pyright",
  -- "custom_elements_ls",
  -- "tailwindcss",
}

for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  })
  vim.lsp.enable(lsp)
end

-- tailwindcss
vim.lsp.config("tailwindcss", {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  settings = {
    validate = true,
    filetypes = { "svelte" },
  },
})
-- vim.lsp.enable "tailwindcss"

local ymlCapabilities = vim.lsp.protocol.make_client_capabilities()
ymlCapabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

vim.lsp.config("yamlls", {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = ymlCapabilities,
  settings = {
    yaml = {
      schemas = {
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
        ["https://json.schemastore.org/catalog-info.json"] = "component.yaml",
      },
    },
  },
})
vim.lsp.enable "yamlls"

-- python-lsp-server (used for styles only)
-- lspconfig["pylsp"].setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   settings = {
--     pylsp = {
--       configurationSources = { "pycodestyle" },
--       plugins = {
--         autopep8 = { enabled = false },
--         pycodestyle = { enabled = true, ignore = { "W391" } },
--         pyflakes = { enabled = false },
--         mccabe = { enabled = false },
--         yapf = { enabled = true },
--       },
--     },
--   },
-- }
-- Robot Framework LSP OVERRIDE
local function root_pattern(pattern)
  return function(startpath)
    local result = vim.fs.find(pattern, { path = startpath, upward = true, type = "file" })
    if #result > 0 then
      return vim.fs.dirname(result[1])
    end
    return startpath -- fallback
  end
end
local virtualenv = os.getenv "VIRTUAL_ENV"
local get_python_path = root_pattern "requirements.txt"
local settings = {
  robot = {
    lint = {
      enabled = true,
      robocop = {
        enabled = true,
      },
      keywordResolvesToMultipleKeywords = false,
    },
  },
}
if virtualenv then
  settings.robot.python = {
    executable = virtualenv .. "/bin/python",
  }
  settings.robot.pythonpath = { get_python_path(virtualenv) }
end
vim.lsp.config("robotframework_ls", {
  cmd = { "robotframework_ls" },
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  settings = settings,
})
vim.lsp.enable "robotframework_ls"

------------------------------------------------------

-- [LSP] Change inline diagnostic text to hover popup
vim.diagnostic.config {
  virtual_text = false,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
}

-- Open diganostic when hover on error words
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    local opts = {
      close_events = { "CursorMoved", "InsertEnter", "FocusLost" },
      focus = false, -- float is not focused immediately, use <C-w>w to focus
      focusable = true,
      border = "rounded",
      source = "always",
      -- prefix = ' ',
      scope = "cursor",
    }
    vim.diagnostic.open_float(nil, opts)
  end,
})
