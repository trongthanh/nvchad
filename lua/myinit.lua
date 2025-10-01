-- global vim

vim.filetype.add {
  extension = {
    njk = "nunjucks", -- nunjucks is registered in treesitter as twig
    hbs = "handlebars", -- actual glimmer
  },
}

-- allows quit all buffers without saving as Shift-Q
vim.api.nvim_create_user_command("Q", "qa<bang>", {
  bang = true,
})

-- Auto commands
local autocmd = vim.api.nvim_create_autocmd
--
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
      -- open file directly
      return
    end

    if directory then
      -- change to the directory
      vim.cmd.cd(data.file)
      -- show nvim-tree initially
      require("nvim-tree.api").tree.open { focus = false }
    end
    if no_name then
      vim.cmd "Nvdash"
    end
  end,
  desc = "Open NvimTree on startup",
})

autocmd("BufDelete", {
  callback = function()
    local bufs = vim.t.bufs
    if #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == "" then
      vim.cmd "Nvdash"
    end
  end,
})
--
-- Highlight yank text
autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 300 }
  end,
  desc = "Highlight yank text",
})

autocmd("FileType", {
  pattern = { "markdown" },
  callback = function()
    -- change surround * to double ** in markdown editor
    vim.g.surround_42 = "**\r**"
    -- required by obsidian.nvim UI
    vim.opt_local.conceallevel = 2
  end,
})

autocmd("BufEnter", {
  pattern = "markdown",
  callback = function(args)
    vim.opt_local.spell = true -- enable spell check just for current buffer
    require("mappings").markdown_preview(args)
  end,
  desc = "Setup markdown buffer type",
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

vim.api.nvim_create_user_command("Space4", function()
  vim.opt.shiftwidth = 4
  vim.opt.tabstop = 4
  vim.opt.expandtab = true
end, { desc = "Set indent width to 4 spaces" })

vim.api.nvim_create_user_command("Space2", function()
  vim.opt.shiftwidth = 2
  vim.opt.tabstop = 2
  vim.opt.expandtab = true
end, { desc = "Set indent width to 2 spaces" })

vim.api.nvim_create_user_command("Tab4", function()
  vim.opt.shiftwidth = 4
  vim.opt.tabstop = 4
  vim.opt.expandtab = false
end, { desc = "Set indent width to 4-char tab" })
-- delay cmp completion workaround
-- taken from https://github.com/hrsh7th/nvim-cmp/issues/715

-- local timer = nil
-- local DELAY = 500
-- autocmd({ "TextChangedI", "CmdlineChanged" }, {
--   pattern = "*",
--   callback = function()
--     if timer then
--       vim.loop.timer_stop(timer)
--       timer = nil
--     end
--
--     timer = vim.loop.new_timer()
--     timer:start(
--       DELAY,
--       0,
--       vim.schedule_wrap(function()
--         require("cmp").complete { reason = require("cmp").ContextReason.Auto }
--       end)
--     )
--   end,
-- })

-- mapping for neovide
if vim.g.neovide then
  vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
  vim.keymap.set("i", "<D-s>", "<ESC>:w<CR>") -- Save insert mode
  vim.keymap.set("v", "<D-c>", '"+y') -- Copy
  vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
  vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
  vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
  vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode
  -- enable Meta key on macOS
  vim.g.neovide_input_macos_option_key_is_meta = "only_left"
  -- enable IME input
  vim.g.neovide_input_ime = true
end
