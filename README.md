NvChad Config for neovim
========================

This is my repo for the `~/.config/nvim` folder in [NvChad config](https://nvchad.com/docs/config/walkthrough#custom_config)

## Installation:

Prerequisites: 

- nvim >= 0.10
- Node.js >= 18, `npm` and `yarn` CLI
- go CLI
- python CLI

For Linux & macOS:

```bash
# Clone this nvim config repo
git clone https://github.com/trongthanh/nvchad ~/.config/nvim
# init settings
nvim
# 1. Lazy will automatically start installing plugins, wait until it's done
# 2. Run :MasonInstallAll to install all servers from this custom config
# 3. Quit nvim to continue

# Remove the .git folder
rm -rf ~/.config/nvim/.git
```

## Language supports (LSP & autoformat)

- HTML
- CSS / SCSS
- JavaScript (eslint & stylelint)
- TypeScript (eslint & stylelint)
- React JSX / TSX
- Svelte
- Vue.js
- Tailwind CSS
- Go lang
- Python
- JSON
- YAML
- Robot Framework
- Lua (nvim's config syntax)

Other languages has syntax highlighting only, such as Markdown, Dockerfile, Bash...

## Included Plugins

Extras from NvChad 2:

- [chentoast/marks.nvim](https://github.com/chentoast/marks.nvim): Persistent marks across files
- [dyng/ctrlsf.vim](https://github.com/dyng/ctrlsf.vim): Ctrl-Shift-F, fuzzy search all files in project
- [folke/flash.nvim](https://github.com/folke/flash.nvim): Easymotion, jump to any position with `s` and `S`)
- [folke/sidekick.nvim](https://github.com/folke/sidekick.nvim): A side panel for running tasks
- [folke/snacks.nvim](https://github.com/folke/snacks.nvim): UI enhancements for neovim
- [folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim): Highlight TODO comments
- [folke/ts-comments.nvim](https://github.com/folke/ts-comments.nvim): Add doc comments for JS/TS
- [godlygeek/tabular](https://github.com/godlygeek/tabular): Alignment, tabular columns (`:Tab /:/l0r1`)
- [iamcco/markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim): Preview Mardown in browser (`Space p m`)
- [kdheepak/lazygit.nvim](https://github.com/kdheepak/lazygit.nvim): Lazygit integration
- [kevinhwang91/nvim-ufo](https://github.com/kevinhwang91/nvim-ufo): Code folding
- [mattn/emmet-vim](https://github.com/mattn/emmet-vim): HTML generator with CSS selector shorthand
- [matze/vim-move](https://github.com/matze/vim-move): Move code block
- [MeanderingProgrammer/render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim): Render markdown in neovim
- [mg979/vim-visual-multi](https://github.com/mg979/vim-visual-multi): Vim multi-cursor (`Ctrl-n`)
- [nvim-scrollbar](https://github.com/petertriho/nvim-scrollbar): Scrollbar with git & LSP signs
- [obsidian-nvim/obsidian.nvim](https://github.com/obsidian-nvim/obsidian.nvim): Manage Obsidian notes
- [sindrets/diffview.nvim](https://github.com/sindrets/diffview.nvim): Git diff viewer
- [tpope/vim-surround](https://github.com/tpope/vim-surround): Brackets and tags generators (vmode: `S)`, nmode: `ysiw)`, `cs"'` )
- [davidmh/mdx.nvim](https://github.com/davidmh/mdx.nvim): MDX support
- [varnishcache-friends/vim-varnish](https://github.com/varnishcache-friends/vim-varnish): VCL syntax support
- [windwp/nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag): Auto tags & brackets closing using treesitter
- [zbirenbaum/copilot.lua](https://github.com/zbirenbaum/copilot.lua): You know what

## Mappings

I've changed a bunch of NvChad default mappings for better actions grouping, for e.g: `<leader>l` for LSP, `<leader>f` for Telescope commands, `<leader>o` for Obsidian...

In addition, I've added some frequently used text objects and shortcuts:

- text lines (`il`, `al`)
- inner quotes (just `c"` instead of `ci"`)
- inner brackets (just `c)` in stead of `ci)`)
- insert current ISO date time (`Ctrl-Alt-t`)

See [mappings.lua](./mappings.lua) OR open cheatsheet (in nvim, `Space c h`) for details.

---
© 2023-current Tran Trong Thanh. MIT License
