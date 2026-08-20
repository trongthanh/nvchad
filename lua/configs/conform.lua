--type conform.options
local options = {
  lsp_fallback = true,

  formatters_by_ft = {
    html = { "oxfmt" },
    handlebars = { "oxfmt" },
    css = { "oxfmt" },
    scss = { "oxfmt" },
    javascript = { "oxfmt" },
    javascriptreact = { "oxfmt" },
    json = { "oxfmt" },
    jsonc = { "oxfmt" },
    typescript = { "oxfmt" },
    typescriptreact = { "oxfmt" },
    vue = { "oxfmt" },
    yaml = { "oxfmt" },
    graphql = { "oxfmt" },
    svelte = { "prettierd" },

    -- lua = { "lsp" },
    lua = { "stylua" },

    go = { "gofmt" },

    python = { "black" }, -- cannot use tabs, consider another formatter
  },

  format_on_save = function(bufnr)
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return { timeout_ms = 5000, lsp_fallback = true }
  end,
}

require("conform").setup(options)

vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})

vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})

-- TODO: reimplement go's organize import
-- The file ends with '.go'
-- if args.file:match "%.go$" then
-- organize import
-- vim.lsp.buf.code_action { context = { only = { "source.organizeImports" } }, apply = true }
-- end
