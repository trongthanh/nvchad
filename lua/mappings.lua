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
map("n", "q", "<Nop>") -- Disable macro recording at q
map("n", "Q", "q", { desc = "general Enter macro recording (instead of q)", nowait = true })
map("n", "<A-q>", "<ESC>:qa<CR>", { desc = "general Quit vim", nowait = true })
map("n", ";", ":", { desc = "general Enter command mode", nowait = true })
map("i", "<C-A-t>", "<C-r>=strftime('%FT%T%z')<CR>", { desc = "Insert ISO Time string" })
map("n", "<C-A-t>", '"=strftime("%FT%T%z")<CR>P', { desc = "Insert ISO Time string" })
map("i", "<C-A-d>", "<C-r>=strftime('%F')<CR>", { desc = "Insert ISO Date string" })
map("n", "<C-A-d>", '"=strftime("%F")<CR>P', { desc = "Insert ISO Date string" })
map("n", "<C-A-f>", ":%s/", { desc = "general Search and replace prompt" })
map("n", "<C-A-z>", "<cmd> set wrap! <CR>", { desc = "Toggle soft wrap" })
map("n", "<C-S-a>", "ggVG", { desc = "selection Select all" })
map("n", "<C-S-c>", "<cmd> %y+ <CR>", { desc = "general Copy whole file to clipboard" })
map("n", "<C-c>", '^vg_"+y', { desc = "general Copy current inner line to clipboard", noremap = true, silent = true })
map("n", "<leader>cw", "g<C-g>", { desc = "general Count words in buffer" })
map("n", "<leader>gd", ":DiffviewOpen<CR>", { desc = "git DiffviewOpen" })
map("n", "<leader>gg", ":LazyGit<CR>", { desc = "git LazyGit" })
map("n", "<leader>gx", ":DiffviewClose<CR>", { desc = "git DiffviewClose" })
map("n", "<leader>nn", "<cmd> set nu! <CR>", { desc = "Toggle line number" })
map("n", "<leader>nr", "<cmd> set rnu! <CR>", { desc = "Toggle relative number" })
map("n", "<leader>q", "<C-w>q", { desc = "general Close (split) window" })

map("n", "<C-A-left>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-A-right>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-A-down>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-A-up>", "<C-w>k", { desc = "switch window up" })

map("v", "<C-f>", 'y<ESC>/<c-r>"<CR>', { desc = "selection Search current selection" })
map("v", "<C-h>", ":s/\\%V", { desc = "selection Start search and replace within selection" })
map("v", "<C-c>", '"+y', { desc = "selection Copy selection to clipboard" })
-- homemade block comment at selection
map(
  "v",
  "/",
  "<Esc>`>a */<Esc>`<i/* <Esc>",
  { desc = "selection Wrap selection in block comment /* */ ", noremap = true, silent = true }
)

-- Text objects
map("v", "'", "i'", { desc = "TextObject inner quotes", noremap = true, silent = true })
map("v", '"', 'i"', { desc = "TextObject inner quotes", noremap = true, silent = true })
map("v", "`", "i`", { desc = "TextObject inner quotes", noremap = true, silent = true })
map("v", "]", "i]", { desc = "TextObject inner brackets", noremap = true, silent = true })
map("v", "}", "i}", { desc = "TextObject inner brackets", noremap = true, silent = true })
map("v", ")", "i)", { desc = "TextObject inner brackets", noremap = true, silent = true })

map("x", "il", "g_o^", { desc = "TextObject Inner line", silent = true })
map("x", "al", "$o0", { desc = "TextObject Outer line", silent = true })

map("o", "il", ":<c-u>normal! g_v^<cr>", { desc = "TextObject Inner line", silent = true })
map("o", "al", ":<c-u>normal! $v0<cr>", { desc = "TextObject Outer line", silent = true })
map("o", '"', ':<c-u>normal! vi"<cr>', { desc = "TextObject Inner quote", silent = true })
map("o", "'", ":<c-u>normal! vi'<cr>", { desc = "TextObject Inner quote", silent = true })
map("o", "`", ":<c-u>normal! vi`<cr>", { desc = "TextObject Inner quote", silent = true })
map("o", "]", ":<c-u>normal! vi]<cr>", { desc = "TextObject Inner brackets", silent = true })
map("o", "}", ":<c-u>normal! vi}<cr>", { desc = "TextObject Inner brackets", silent = true })
map("o", ")", ":<c-u>normal! vi)<cr>", { desc = "TextObject Inner brackets", silent = true })

-- NvimTree mappings
map("n", "<C-b>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree Toggle nvimtree" })
lazy.nvimtree = function(bufnr, api, cmds)
  local function opts(desc)
    return { desc = "nvimtree " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  map("n", "<leader>e", "<C-w>w", opts "Focus editor")
  map("n", "?", api.tree.toggle_help, opts "Help")
  map("n", "ga", cmds.git_add, opts "Git add current file")
  map("n", "A", cmds.avante_add_file, opts "Avante add current file")
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
map("n", "<leader>X", function()
  require("nvchad.tabufline").closeAllBufs(false)
end, { desc = "tabufline Close all other buffers" })
map("n", "<A-w>", require("nvchad.tabufline").close_buffer, { desc = "tabufline Close buffer" })
map("n", "]t", require("nvchad.tabufline").next, { desc = "tabufline Goto next buffer" })
map("n", "[t", require("nvchad.tabufline").prev, { desc = "tabufline Goto prev buffer" })

-- LSPConfig mappings
lazy.lspconfig = function(client, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end
  nomap("n", "<leader>ra", opts "renamer")

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
  map({ "n", "v" }, "<leader>la", function()
    vim.lsp.buf.code_action()
  end, opts "code action")
end

-- Quickfix mappings
lazy.quickfix = function()
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
    -- Find the main editor window (excluding special windows like NvimTree)
    local wins = vim.api.nvim_tabpage_list_wins(0)
    local main_win

    for _, win in ipairs(wins) do
      local buf = vim.api.nvim_win_get_buf(win)
      local bt = vim.bo[buf].buftype
      local ft = vim.bo[buf].filetype
      -- Find a normal window (not special windows like NvimTree, etc)
      if ft == "nvdash" or (bt == "" and ft ~= "NvimTree") then
        main_win = win
        break
      end
    end

    -- Focus main window before toggling terminal
    if main_win then
      vim.api.nvim_set_current_win(main_win)
    end

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
  -- window movement in terminal
  vim.keymap.set(
    "t",
    "<C-M-left>",
    "<C-\\><C-n><C-w>h<C-i>",
    { buffer = args.buf, desc = "terminal switch window left" }
  )
  vim.keymap.set(
    "t",
    "<C-M-right>",
    "<C-\\><C-n><C-w>l<C-i>",
    { buffer = args.buf, desc = "terminal switch window right" }
  )
  vim.keymap.set(
    "t",
    "<C-M-down>",
    "<C-\\><C-n><C-w>j<C-i>",
    { buffer = args.buf, desc = "terminal switch window down" }
  )
  vim.keymap.set("t", "<C-M-up>", "<C-\\><C-n><C-w>k<C-i>", { buffer = args.buf, desc = "terminal switch window up" })
end

-- Cheatsheet mappings
lazy.cheatsheet = function(args)
  map("n", "q", "<C-w>q", { buffer = args.buf, desc = "cheatsheet Close cheat sheet window" })
end

-- CtrlSF mappings
map("n", "<C-S-f>", "<ESC>:CtrlSF ", { desc = "ctrlsf Begin find in files" })
map("v", "<C-S-f>", 'y<ESC>:CtrlSF <c-r>"', { desc = "ctrlsf Find selection in files" })
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
  map("n", "<leader>hr", gitsigns.reset_hunk, { buffer = bufnr, desc = "git Reset hunk" })
  map("n", "<leader>hp", gitsigns.preview_hunk, { buffer = bufnr, desc = "git Preview hunk" })
  map("n", "<leader>hn", gitsigns.next_hunk, { buffer = bufnr, desc = "git Next hunk" })
  map("n", "<leader>hb", gitsigns.prev_hunk, { buffer = bufnr, desc = "git Prev hunk" })
  map("n", "<leader>hs", gitsigns.select_hunk, { buffer = bufnr, desc = "git Select hunk" })
  map("n", "<leader>gb", gitsigns.blame_line, { buffer = bufnr, desc = "git Blame Line" })
end

-- Copilot mappings
-- lazy.copilot = function()
--   map("i", "<M-Space>", function()
--     vim.fn.feedkeys(vim.fn["copilot#Accept"](), "")
--   end, { desc = "copilot Accept", replace_keycodes = false, nowait = true, silent = true, expr = true, noremap = true })
-- end

-- Wiki mappings
lazy.obsidian = function()
  map("n", "<leader>od", ":Obsidian dailies<CR>", { desc = "Obsidian pick dailies" })
  map("n", "<leader>ot", ":Obsidian today<CR>", { desc = "Obsidian open today" })
  map("n", "<leader>oy", ":Obsidian today -1<CR>", { desc = "Obsidian open yesterday" })
  map("n", "<leader>om", ":Obsidian today +1<CR>", { desc = "Obsidian open tomorrow" })
  map("n", "<leader>ob", ":Obsidian backlinks<CR>", { desc = "Obsidian list backlinks" })
  map("n", "<leader>oc", ":Obsidian check<CR>", { desc = "Obsidian check" })
  map("n", "<leader>or", ":Obsidian rename<CR>", { desc = "Obsidian rename" })
  map("n", "<leader>os", ":Obsidian search<CR>", { desc = "Obsidian search" })
  map("n", "<leader>ol", ":Obsidian links<CR>", { desc = "Obsidian list links" })
  map("v", "<leader>ol", ":Obsidian link<CR>", { desc = "Obsidian link" })
  map("v", "<leader>on", ":Obsidian link_new<CR>", { desc = "Obsidian new link" })
  map("v", "<leader>oe", ":Obsidian extract_note<CR>", { desc = "Obsidian extract note" })
  map("v", "<leader>oq", ":Obsidian quick_switch<CR>", { desc = "Obsidian quick switch" })
end

lazy.avante = {
  {
    "<C-M-i>",
    function()
      local avante = require "avante"
      local sidebar = avante.get()
      local curbuf = vim.api.nvim_get_current_buf()
      if not sidebar then
        return
      end
      --
      if
        sidebar:is_open() and (curbuf == sidebar.input_container.bufnr or curbuf == sidebar.result_container.bufnr)
      then
        -- input in sidebar
        avante.close_sidebar()
      else
        -- input in editor buffer
        vim.cmd "AvanteAsk"
      end
    end,
    mode = { "n", "i" },
    desc = "avante: Toggle or Focus",
  },
}

-- lazy mappings for lazy plugins & autocmds
return lazy
