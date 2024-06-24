-- global vim

vim.filetype.add {
  extension = {
    mdx = "markdown", -- map mdx to markdown, until native support
    njk = "nunjucks", -- nunjucks is registered in treesitter as twig
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
-- show column limit bar when textwidth is set
opt.colorcolumn = "+1"
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

-- Open NvimTree on startup
autocmd("VimEnter", {
  -- pattern = "",
  callback = function(data)
    -- buffer is a directory
    local directory = vim.fn.isdirectory(data.file) == 1

    -- buffer is a [No Name]
    local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

    if not directory and not no_name then
      return
    end

    if directory then
      -- change to the directory
      vim.cmd.cd(data.file)
    end

    require("nvim-tree.api").tree.toggle { focus = false }

    if no_name then
      vim.cmd "Nvdash"
    end
  end,
  desc = "Open NvimTree on startup",
})

-- Highlight yank text
autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 300 }
  end,
  desc = "Highlight yank text",
})

-- change surround * to double ** in markdown
autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.g.surround_42 = "**\r**"
    vim.opt.spell = true -- enable spell check
  end,
  desc = "Change surround * to double ** in markdown",
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

autocmd("FileType", {
  pattern = "terminal",
  callback = function(args)
    -- close terminal
    vim.keymap.set("n", "<C-x>", function()
      require("nvchad.tabufline").close_buffer()
    end, { buffer = args.buf })
  end,
})

vim.api.nvim_create_user_command("Indent4", function()
  vim.bo.shiftwidth = 4
  vim.bo.tabstop = 4
  vim.bo.expandtab = true
end, { desc = "Set indent width to 4 spaces" })

vim.api.nvim_create_user_command("Indent2", function()
  vim.bo.shiftwidth = 4
  vim.bo.tabstop = 4
  vim.bo.expandtab = true
end, { desc = "Set indent width to 4 spaces" })
