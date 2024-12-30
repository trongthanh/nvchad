-- global vim

vim.filetype.add {
  extension = {
    mdx = "markdown", -- map mdx to markdown, until native support
    njk = "nunjucks", -- nunjucks is registered in treesitter as twig
    hbs = "handlebars", -- actual glimmer
  },
}

-- allows quit all buffers without saving
vim.api.nvim_create_user_command("Q", "qa<bang>", {
  bang = true,
})

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
      -- show nvim-tree initially
      require("nvim-tree.api").tree.toggle { focus = false }
    end

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
  callback = function(args)
    vim.g.surround_42 = "**\r**"
    vim.opt.spell = true -- enable spell check
    require("mappings").markdown_preview(args)
  end,
  desc = "Change surround * to double ** in markdown",
})

-- close quickfix menu after selecting choice
autocmd("FileType", {
  pattern = { "qf" },
  callback = require("mappings").quickfix,
})

autocmd("TermOpen", {
  callback = require("mappings").terminal,
})

autocmd("BufEnter", {
  pattern = "term://*",
  -- command = "startinsert",
  callback = function()
    vim.cmd "startinsert"
  end,
})

autocmd("FileType", {
  pattern = "nvcheatsheet",
  callback = require("mappings").cheatsheet,
})

vim.api.nvim_create_user_command("Indent4", function()
  vim.bo.shiftwidth = 4
  vim.bo.tabstop = 4
  vim.bo.expandtab = true
end, { desc = "Set indent width to 4 spaces" })

vim.api.nvim_create_user_command("Indent2", function()
  vim.bo.shiftwidth = 2
  vim.bo.tabstop = 2
  vim.bo.expandtab = true
end, { desc = "Set indent width to 2 spaces" })

vim.api.nvim_create_user_command("Tab4", function()
  vim.bo.shiftwidth = 4
  vim.bo.tabstop = 4
  vim.bo.expandtab = false
end, { desc = "Set indent width to 4-char tab" })
-- delay cmp completion workaround
-- taken from https://github.com/hrsh7th/nvim-cmp/issues/715

local timer = nil
local DELAY = 1000
autocmd({ "TextChangedI", "CmdlineChanged" }, {
  pattern = "*",
  callback = function()
    if timer then
      vim.loop.timer_stop(timer)
      timer = nil
    end

    timer = vim.loop.new_timer()
    timer:start(
      DELAY,
      0,
      vim.schedule_wrap(function()
        require("cmp").complete { reason = require("cmp").ContextReason.Auto }
      end)
    )
  end,
})
