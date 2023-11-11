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
        callback = function(args)
          -- print(vim.inspect(args))
          vim.lsp.buf.format { async = false }
          -- The file ends with '.go'
          if args.file:match "%.go$" then
            -- organize import
            vim.lsp.buf.code_action { context = { only = { "source.organizeImports" } }, apply = true }
          end
        end,
      })
    end
  end,
}
