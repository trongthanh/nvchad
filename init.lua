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

-- do not use clipboard for register
opt.clipboard = ""

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

-- force NvimTree window to normal mode
autocmd("BufEnter", {
  pattern = "NvimTree*",
  command = "stopinsert",
})
