-- Options
require "nvchad.options"

local opt = vim.opt
-- enable update terminal title
opt.title = true
-- enable blinking caret
opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25-blinkon300-blinkoff200,r-cr-o:hor20"
-- enable local .nvim.lua, .nvimrc, .exrc files
opt.exrc = true

-- indent and whitespaces
opt.expandtab = false -- use tabs by default, to be overriden by .editorconfig
opt.listchars = "tab:‣ ,trail:~,extends:›,precedes:‹" -- space:·
opt.list = true
-- lines and wrap
opt.linebreak = true
-- show column limit bar when textwidth is set
opt.colorcolumn = "+1"
-- do not use clipboard for register
opt.clipboard = ""
-- add trailing newline
opt.fixeol = true
-- scroll offset
opt.scrolloff = 5
-- for avante plugin: views can only be fully collapsed with the global statusline
opt.laststatus = 3
