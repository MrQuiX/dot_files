-- disable netrw at the very start of your init.lua (strongly advised)
-- nvim-tree requires this
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- sometimes neovim can't remember where python is if you install with linuxbrew
-- if vim.loop.os_uname().sysname == 'Linux'
--	then
--    vim.g.python3_host_prog = '/home/linuxbrew/.linuxbrew/bin/python3.11'
-- end

-- turn off the mouse scrolling because it is confusing
vim.opt.mousescroll = 'ver:0,hor:0'

-- line numbers for debugging and screen sharing, takes up 4 columns
vim.opt.number = true
vim.opt.numberwidth = 4

-- highlight current line
vim.opt.cursorline = true

-- highlighted column 80, only on python files, to keep lines shorter
vim.opt.colorcolumn = '80'

-- vim.opt.termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- make searching case insensitive
vim.opt.ignorecase = true

-- indentation
require('user.indent')

-- both of these are required to make packer, our plugin manager, work
require('plugins')
vim.cmd.source("~/.config/nvim/packerinit.vim")

-- --------- Plugin configs that have to be called after packer --------------
-- Colors need to be enabled after the plugins, because the colors are a plugin
vim.cmd.colorscheme('spacechalk')
vim.g.colors_name = 'spacechalk'

-- starting page for neovim
require('user.dashboard')

-- Language Server configs and other syntax checking and highlight tools
require('user.lsp-configs')
require('user.tree-sitter')

-- completion from nvim-cmp
require('user.completion')

-- folding
require('user.folding')

-- linter/fixer
require('user.ale')

-- syntax highlgihting for hex codes
require('user.nvim-colorizer')

-- status line for vim; may change to galazyline or lualine; need to latest airline features
require('user.airline')

-- directory tree for neovim; can option with :NvimTreeToggle
require('user.nvim-tree')

-- scrollbar on the right side of the screen that also shows errors
require("scrollbar").setup({
    set_highlights = false,
    handlers = {
        cursor = true,
        diagnostic = true,
        handle = true,
        -- search = false, -- Requires hlslens
        ale = true,
    },
})

-- floating windows
require('user.fterm')
