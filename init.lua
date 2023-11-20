-- global vim

vim.filetype.add {
  extension = {
    mdx = "markdown", -- map mdx to markdown, until native support
  },
}

-- allows quit all buffers without saving
vim.api.nvim_create_user_command("Q", "qa<bang>", {
  bang = true,
})

-- Options
local opt = vim.opt
-- enable update terminal title
opt.title = true
-- enable blinking caret
opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25-blinkon300-blinkoff200,r-cr-o:hor20"

-- indent and whitespaces
opt.expandtab = false -- use tabs by default, to be overriden by .editorconfig
opt.listchars = "tab:‣─,trail:~,extends:›,precedes:‹" -- space:·
opt.list = true
-- do not use clipboard for register
opt.clipboard = ""
-- add trailing newline
opt.fixeol = true
-- Auto commands
local autocmd = vim.api.nvim_create_autocmd
--
--

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
--

-- Highlight yank text
autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 300 }
  end,
})

-- change surround * to double ** in markdown
autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.g.surround_42 = "**\r**"
  end,
})

-- close quickfix menu after selecting choice
autocmd("FileType", {
  pattern = { "qf" },
  callback = function()
    -- vim.cmd [[nnoremap <buffer> <CR> <CR>:cclose<CR>]]

    vim.keymap.set(
      "n",
      "<CR>",
      "<CR>:cclose<CR>",
      { desc = "Quickfix: Close", buffer = true, noremap = true, silent = true, nowait = true }
    )
    vim.keymap.set(
      "n",
      "q",
      ":cclose<CR>",
      { desc = "Quickfix: Close", buffer = true, noremap = true, silent = true, nowait = true }
    )
  end,
})
