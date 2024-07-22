-- nvchad mappings: https://github.com/NvChad/NvChad/blob/v2.5/lua/nvchad/mappings.lua
require "nvchad.mappings"

local map = vim.keymap.set
local nomap = vim.keymap.del
local lazy = {}

-- Disabled mappings
nomap("n", "<leader>n") -- line number
nomap("n", "<leader>rn") -- relative number
nomap("n", "<leader>fm") -- conform format
nomap("n", "<leader>ds") -- loclist
-- telescope
nomap("n", "<leader>cm")
nomap("n", "<leader>ma")
nomap("n", "<leader>pt")
-- new term
nomap("n", "<leader>h")
nomap("n", "<leader>v")

-- General mappings
map("n", "<A-q>", "<ESC>:qa<CR>", { desc = "general Quit vim", nowait = true })
map("n", ";", ":", { desc = "general Enter command mode", nowait = true })
map("i", "<C-A-t>", "<C-r>=strftime('%FT%T%z')<CR>", { desc = "general Insert ISO Time string" })
map("n", "<C-A-t>", '"=strftime("%FT%T%z")<CR>P', { desc = "general Insert ISO Time string" })
map("n", "<C-A-f>", ":%s/", { desc = "general Search and replace prompt" })
map("n", "<C-A-z>", "<cmd> set wrap! <CR>", { desc = "general Toggle soft wrap" })
map("n", "<C-S-a>", "ggVG", { desc = "general Select all" })
map("n", "<C-S-c>", "<cmd> %y+ <CR>", { desc = "general Copy whole file to clipboard" })
map("n", "<C-c>", '^vg_"+y', { desc = "general Copy current inner line to clipboard", noremap = true, silent = true })
map("n", "<leader>cw", "g<C-g>", { desc = "general Count words in buffer" })
map("n", "<leader>gd", ":DiffviewOpen<CR>", { desc = "general DiffviewOpen" })
map("n", "<leader>gg", ":LazyGit<CR>", { desc = "general LazyGit" })
map("n", "<leader>gx", ":DiffviewClose<CR>", { desc = "general DiffviewClose" })
map("n", "<leader>nn", "<cmd> set nu! <CR>", { desc = "general Toggle line number" })
map("n", "<leader>nr", "<cmd> set rnu! <CR>", { desc = "general Toggle relative number" })
map("n", "<leader>q", "<C-w>q", { desc = "general Close (split) window" })

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
lazy.nvimtree_git_add = function(args, git_add)
  map("n", "ga", git_add, { buffer = args.buf, desc = "nvimtree Git Add" })
end

-- Telescope mappings
map("n", "<C-S-p>", "<cmd> Telescope commands <CR>", { desc = "Telescope Open commands panel" })
map("n", "<C-p>", "<cmd> Telescope find_files hidden=true <CR>", { desc = "Telescope Find files" })
map("n", "<C-f>", "<cmd> Telescope current_buffer_fuzzy_find <CR>", { desc = "Telescope Find in current buffer" })
map("n", "<C-t>", "<cmd> Telescope treesitter <CR>", { desc = "Telescope Find symbols" })
map("n", "<leader>gc", "<cmd> Telescope git_commits <CR>", { desc = "Telescope Git čommits" })
map("n", "<leader>fm", "<cmd> Telescope marks <CR>", { desc = "Telescope Bookṃarks" })
map("n", "<leader>ft", "<cmd> Telescope terms <CR>", { desc = "Telescope Pick hidden ṯerm" })
map("n", "<leader>fd", "<cmd> TodoTelescope <CR>", { desc = "Telescope Find TOḎOs" })

-- Tabufline mappings
-- Note closeAllBufs(include_cur_buf)
map("n", "<leader>X", require("nvchad.tabufline").closeAllBufs, { desc = "tabufline Close all other buffers" })
map("n", "<A-w>", require("nvchad.tabufline").close_buffer, { desc = "tabufline Close buffer" })
map("n", "]t", require("nvchad.tabufline").next, { desc = "tabufline Goto next buffer" })
map("n", "[t", require("nvchad.tabufline").prev, { desc = "tabufline Goto prev buffer" })

-- LSPConfig mappings
lazy.lspconfig = function(client, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end
  -- Change lspconfig shortcuts to <leader>l*
  nomap({ "n", "v" }, "<leader>ca", opts "code action")
  nomap("n", "<leader>ra", opts "renamer")
  nomap("n", "<leader>sh", opts "signature help")

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
  map("n", "<leader>ls", function()
    vim.lsp.buf.signature_help()
  end, opts "signature help")
  map("n", "<leader>r", function()
    require "nvchad.lsp.renamer"()
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
map({ "n" }, "<C-`>", function()
  local term = require "nvchad.term"
  local nvchad_terms = vim.g.nvchad_terms
  local term_id = "htoggleTerm"
  local term_info

  for _, opts in pairs(nvchad_terms) do
    if opts.id == term_id then
      term_info = opts
    end
  end

  -- Check if the terminal buffer is already open in another window
  if term_info and term_info.buf and vim.fn.bufwinid(term_info.buf) ~= -1 then
    -- Focus the existing terminal window
    vim.api.nvim_set_current_win(vim.fn.bufwinid(term_info.buf))
    vim.cmd "startinsert"
  else
    -- Toggle the terminal as usual
    term.toggle { pos = "sp", id = term_id }
  end
end, { desc = "terminal Toggle or Focus terminal" })

map({ "t" }, "<C-`>", "<C-\\><C-n><C-w>W", { desc = "terminal Blur terminal" })

lazy.terminal = function(args)
  -- close terminal
  vim.keymap.set("n", "<C-x>", function()
    require("nvchad.tabufline").close_buffer()
  end, { buffer = args.buf, desc = "terminal Close terminal" })
end

-- Cheatsheet mappings
lazy.cheatsheet = function(args)
  map("n", "q", "<C-w>q", { buffer = args.buf, desc = "cheatsheet Close cheat sheet window" })
end

-- CtrlSF mappings
map("n", "<C-S-f>", "<Esc> :CtrlSF ", { desc = "ctrlsf Begin find in files" })
map("n", "<leader>tf", "<cmd> CtrlSFToggle <CR>", { desc = "ctrlsf Toggle CtrlSF Window" })

-- MarkdownPreview mappings
lazy.markdown_preview = function(args)
  map(
    "n",
    "<leader>pm",
    "<cmd> MarkdownPreview <CR>",
    { buffer = args.buf, desc = "markdown_preview Preview Markdown" }
  )
end

-- Gitsigns mappings
lazy.gitsigns = function(bufnr, gitsigns)
  map("n", "<leader>hr", gitsigns.reset_hunk, { buffer = bufnr, desc = "gitsigns Reset hunk" })
  map("n", "<leader>hp", gitsigns.preview_hunk, { buffer = bufnr, desc = "gitsigns Preview hunk" })
  map("n", "<leader>hn", gitsigns.next_hunk, { buffer = bufnr, desc = "gitsigns Next hunk" })
  map("n", "<leader>hb", gitsigns.prev_hunk, { buffer = bufnr, desc = "gitsigns Prev hunk" })
  map("n", "<leader>hs", gitsigns.select_hunk, { buffer = bufnr, desc = "gitsigns Select hunk" })
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

-- lazy mappings for lazy plugins & autocmds
return lazy
