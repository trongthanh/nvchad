local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "eslint", "stylelint_lsp", "jsonls", "gopls", "tailwindcss", "yamlls" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- Vue.js language server
lspconfig["volar"].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    typescript = {
      tsdk = "/usr/local/lib/node_modules/typescript/lib",
    },
  },
}

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
-- MS python language server
lspconfig["pyright"].setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

-- [LSP] Change inline diagnostic text to hover popup
vim.diagnostic.config {
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
}

-- Open diganostic when hover on error words
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    local opts = {
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
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
