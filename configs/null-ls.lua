local null_ls = require "null-ls"

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  b.formatting.prettierd.with {
    filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
      "css",
      "scss",
      "less",
      "html",
      "json",
      "jsonc",
      "yaml",
      "graphql",
      "handlebars",
    },
  }, -- so prettier works only on these filetypes

  -- Lua
  b.formatting.stylua,

  -- Go
  b.formatting.gofmt,
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup {
  debug = true,
  sources = sources,
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
          -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
          vim.lsp.buf.format { async = false }
        end,
      })
    end
  end,
}
