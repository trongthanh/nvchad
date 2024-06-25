require "nvchad.mappings"

local map = vim.keymap.set
local nomap = vim.keymap.del
local lazy = {}

-- Disabled mappings
-- reserve this shortcut for vim-visual-multi
nomap("n", "<C-n>")
nomap("n", "<leader>n") -- line number
nomap("n", "<leader>rn") -- relative number
nomap("n", "<leader>fm") -- conform format
nomap("n", "<leader>ds") -- loclist
-- telescope
nomap("n", "<leader>cm")
nomap("n", "<leader>ma")
-- new term
nomap("n", "<leader>h")
nomap("n", "<leader>v")

-- General mappings
map("i", "<C-A-t>", "<C-r>=strftime('%FT%T%z')<CR>", { desc = "general Insert ISO Time string" })
map("n", ";", ":", { desc = "general Enter command mode", nowait = true })
map("n", "<C-A-z>", "<cmd> set wrap! <CR>", { desc = "general Toggle soft wrap" })
map("n", "<leader>q", "<C-w>q", { desc = "general Close (split) window" })
map("n", "<C-A-f>", ":%s/", { desc = "general Search and replace prompt" })
map("n", "<leader>nn", "<cmd> set nu! <CR>", { desc = "general Toggle line number" })
map("n", "<leader>nr", "<cmd> set rnu! <CR>", { desc = "general Toggle relative number" })
map("n", "<C-A-t>", '"=strftime("%FT%T%z")<CR>P', { desc = "general Insert ISO Time string" })
map("n", "<C-S-a>", "ggVG", { desc = "general Select all" })
map("n", "<leader>gg", ":LazyGit<CR>", { desc = "general LazyGit" })
map("n", "<leader>gd", ":DiffviewOpen<CR>", { desc = "general DiffviewOpen" })
map("n", "<leader>gx", ":DiffviewClose<CR>", { desc = "general DiffviewClose" })
map("n", "<leader>X", "<cmd> %bd <CR>", { desc = "general Close all (unedited) buffers" })
map("n", "<leader>cw", "g<C-g>", { desc = "general Count words in buffer" })
map("n", "<C-S-c>", "<cmd> %y+ <CR>", { desc = "general Copy whole file to clipboard" })
map("n", "<C-c>", '^vg_"+y', { desc = "general Copy current inner line to clipboard", noremap = true, silent = true })

map("v", "<C-f>", 'y<ESC>/<c-r>"<CR>', { desc = "general Search current selection" })
map("v", "<C-h>", ":s/\\%V", { desc = "general Start search and replace within selection" })
map("v", "<C-c>", '"+y', { desc = "general Copy selection to clipboard" })

-- Text objects
map("v", "'", "i'", { desc = "general Select inner quotes shortcut" })
map("v", '"', 'i"', { desc = "general Select inner quotes shortcut" })
map("v", "`", "i`", { desc = "general Select inner quotes shortcut" })
map("v", "]", "i]", { desc = "general Select inner brackets shortcut" })
map("v", "}", "i}", { desc = "general Select inner brackets shortcut" })
map("v", ")", "i)", { desc = "general Select inner brackets shortcut" })

map("x", "il", "g_o^", { desc = "general Inner line object", silent = true })
map("x", "al", "$o0", { desc = "general Outer line object", silent = true })

map("o", "il", ":<c-u>normal! g_v^<cr>", { desc = "general Inner line object", silent = true })
map("o", "al", ":<c-u>normal! $v0<cr>", { desc = "general Outer line object", silent = true })
map("o", '"', ':<c-u>normal! vi"<cr>', { desc = "general Inner quote object", silent = true })
map("o", "'", ":<c-u>normal! vi'<cr>", { desc = "general Inner quote object", silent = true })
map("o", "`", ":<c-u>normal! vi`<cr>", { desc = "general Inner quote object", silent = true })
map("o", "]", ":<c-u>normal! vi]<cr>", { desc = "general Inner brackets object", silent = true })
map("o", "}", ":<c-u>normal! vi}<cr>", { desc = "general Inner brackets object", silent = true })
map("o", ")", ":<c-u>normal! vi)<cr>", { desc = "general Inner brackets object", silent = true })

-- NvimTree mappings
map("n", "<C-b>", "<cmd> NvimTreeToggle <CR>", { desc = "nvimtree Toggle nvimtree" })
lazy.nvimtree = function(args)
  map("n", "ga", require("configs.nvimtree").git_add, { buffer = args.buf, desc = "nvimtree Git Add" })
end

-- Telescope mappings
map("n", "<C-S-p>", "<cmd> Telescope commands <CR>", { desc = "telescope Open commands panel" })
map("n", "<C-p>", "<cmd> Telescope find_files hidden=true <CR>", { desc = "telescope Find files" })
map("n", "<C-f>", "<cmd> Telescope current_buffer_fuzzy_find <CR>", { desc = "telescope Find in current buffer" })
map("n", "<C-t>", "<cmd> Telescope treesitter <CR>", { desc = "telescope Find symbols" })
map("n", "<leader>gc", "<cmd> Telescope git_commits <CR>", { desc = "telescope Git commits" })
map("n", "<leader>tm", "<cmd> Telescope marks <CR>", { desc = "telescope Bookmarks" })

-- Tabufline mappings
map("n", "<A-w>", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "tabufline Close buffer" })
map("n", "]t", function()
  require("nvchad.tabufline").tabuflineNext()
end, { desc = "tabufline Goto next buffer" })
map("n", "[t", function()
  require("nvchad.tabufline").tabuflinePrev()
end, { desc = "tabufline Goto prev buffer" })

-- LSPConfig mappings
lazy.lspconfig = function(client, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end
  -- Change lspconfig shortcuts to <leader>l*
  nomap({ "n", "v" }, "<leader>ca", opts "code action") -- LSP code action
  nomap("n", "<leader>ra", opts "rename") -- renamer
  -- Set new shortcuts
  map("n", "<leader>d", function()
    vim.diagnostic.open_float { border = "rounded" }
  end, opts "diagnostic")
  map("n", "<leader>lf", function()
    vim.lsp.buf.format { async = true }
  end, opts "format")
  map("n", "<leader>ll", function()
    vim.diagnostic.setloclist()
  end, opts "Diagnostic setloclist")
  map("n", "<leader>r", function()
    require("nvchad.lsp.renamer").open()
  end, opts "rename")
  map({ "n", "v" }, "<leader>a", function()
    vim.lsp.buf.code_action()
  end, opts "code action")
end

-- Quickfix mappings
lazy.quickfix = function(args)
  map("n", "<CR>", "<CR>:cclose<CR>", { desc = "Quickfix Close", buffer = true, silent = true, nowait = true })
  map("n", "q", ":cclose<CR>", { desc = "Quickfix Close", buffer = true, silent = true, nowait = true })
end

-- Terminal mappings
map({ "n", "t" }, "<C-`>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal Toggle terminal" })

lazy.terminal = function(args)
  -- close terminal
  vim.keymap.set("n", "<C-x>", function()
    require("nvchad.tabufline").close_buffer()
  end, { buffer = args.buf, desc = "terminal Close terminal" })
end

-- Cheatsheet mappings
lazy.cheatsheet = function(args)
  map("n", "q", "<C-w>q", { buffer = args.buff, desc = "cheatsheet Close cheat sheet window" })
end

-- CtrlSF mappings
map("n", "<C-S-f>", "<Esc> :CtrlSF ", { desc = "ctrlsf Begin find in files" })
map("n", "<leader>tf", "<cmd> CtrlSFToggle <CR>", { desc = "ctrlsf Toggle CtrlSF Window" })

-- MarkdownPreview mappings
lazy.markdown_preview = function()
  map("n", "<leader>pm", "<cmd> MarkdownPreview <CR>", { desc = "markdown_preview Preview Markdown" })
end

-- Gitsigns mappings
lazy.gitsigns = function(bufnr, gitsigns)
  map("n", "<leader>hr", gitsigns.reset_hunk, { buffer = bufnr, desc = "gitsigns Reset hunk" })
  map("n", "<leader>hp", gitsigns.preview_hunk, { buffer = bufnr, desc = "gitsigns Preview hunk" })
  map("n", "<leader>gb", gitsigns.blame_line, { buffer = bufnr, desc = "gitsigns Blame Line" })
end

-- Copilot mappings
lazy.copilot = function()
  map("i", "<C-Space>", function()
    vim.fn.feedkeys(vim.fn["copilot#Accept"](), "")
  end, { desc = "copilot Accept", replace_keycodes = true, nowait = true, silent = true, expr = true, noremap = true })
end

-- Wiki mappings
lazy.wiki = function()
  map("n", "<leader>wji", ":WikiJournalIndex<CR>", { desc = "wiki Insert Journal Index" })
end

-- lazy mappings for lazy plugins
return lazy
