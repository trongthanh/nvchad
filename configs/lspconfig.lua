local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "eslint", "stylelint_lsp", "gopls", "tailwindcss" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

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
      focusable = false, -- focus with Tab and Esc, turn off since it often focus accidentally, use the shortcut Space-d then C-w w instead
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = "rounded",
      source = "always",
      -- prefix = ' ',
      scope = "cursor",
    }
    vim.diagnostic.open_float(nil, opts)
  end,
})
