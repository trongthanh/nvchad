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
- Vue.js
- Tailwind CSS
- Go lang
- Python
- JSON
- YAML
- Lua (nvim's config syntax)

Other languages has syntax highlighting only, such as Markdown, Dockerfile, Bash...

## Included Plugins

Extras from NvChad 2:

- [dyng/ctrlsf.vim](https://github.com/dyng/ctrlsf.vim): Ctrl-Shift-F, fuzzy search all files in project
- [ggandor/leap.nvim](https://github.com/ggandor/leap.nvim): Easymotion, jump to any position with `s` and `S`)
- [github/copilot.vim](https://github.com/github/copilot.vim): You know what
- [godlygeek/tabular](https://github.com/godlygeek/tabular): Alignment, tabular columns (`:Tab /:/l0r1`)
- [iamcco/markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim): Preview Mardown in browser (`Space p m`)
- [jackMort/ChatGPT.nvim](https://github.com/jackMort/ChatGPT.nvim): Experiment, turn off by default
- [lervag/wiki.vim](https://github.com/lervag/wiki.vim): Experiment, manage personal wiki / journal repo (wiki path ~/Documents/wiki) 
- [mattn/emmet-vim](https://github.com/mattn/emmet-vim): HTML generator with CSS selector shorthand
- [matze/vim-move](https://github.com/matze/vim-move): Move code block
- [mg979/vim-visual-multi](https://github.com/mg979/vim-visual-multi): Vim multi-cursor (`Ctrl-n`)
- [mracos/mermaid.vim](https://github.com/mracos/mermaid.vim): Mermaid syntax support
- [nvim-scrollbar](https://github.com/petertriho/nvim-scrollbar): Scrollbar with git & LSP signs
- [tpope/vim-surround](https://github.com/tpope/vim-surround): Brackets and tags generators (vmode: `S)`, nmode: `ysiw)`, `cs"'` )
- [windwp/nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag): Auto tags & brackets closing using treesitter

## Mappings

I've changed a bunch of NvChad default mappings for better actions grouping, for e.g: `Spc l` for LSP, `Spc f` for Telescope commands, `Spc w` for wiki...

In addition, I've added some frequently used text objects and shortcuts:

- text lines (`il`, `al`)
- inner quotes (just `c"` instead of `ci"`)
- inner brackets (just `c)` in stead of `ci)`)
- insert current ISO date time (`Ctrl-Alt-t`)

See [mappings.lua](./mappings.lua) OR open cheatsheet (in nvim, `Space c h`) for details.

---
© 2023-current Tran Trong Thanh. MIT License
