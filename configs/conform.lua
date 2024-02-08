--type conform.options
local options = {
  lsp_fallback = true,

  formatters_by_ft = {
    html = { "prettierd" },
    handlebars = { "prettierd" },
    css = { "prettierd" },
    scss = { "prettierd" },
    javascript = { "prettierd" },
    javascriptreact = { "prettierd" },
    json = { "prettierd" },
    jsonc = { "prettierd" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
    vue = { "prettierd" },
    yaml = { "prettierd" },
    graphql = { "prettierd" },

    lua = { "stylua" },

    go = { "gofmt" },
    python = { "black" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

require("conform").setup(options)

-- TODO: reimplement go's organize import
-- The file ends with '.go'
-- if args.file:match "%.go$" then
-- organize import
-- vim.lsp.buf.code_action { context = { only = { "source.organizeImports" } }, apply = true }
-- end
