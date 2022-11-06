-- disable netrw at the very start of your init.lua (strongly advised)
-- nvim-tree requires this
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- vim.opt.window to 82 characters at start, to allow for line numbers & gitgutter
vim.opt.winwidth = 82

-- line numbers for debugging and screen sharing, takes up 4 columns
vim.opt.number = true
vim.opt.numberwidth = 4

-- highlight current line - very useful, shouldn't turn off, you will be lost
vim.opt.cursorline = true

-- highlighted column 80, only on python files, to keep lines shorter
vim.opt.colorcolumn = '80'

-- vim.opt.termguicolors to enable highlight groups
vim.opt.termguicolors = true

--                             FOLDING ZONE:
--                 collapse an entire block or function
-- ---------------------------------------------------------------------------
-- Enable folding on base indent
vim.opt.foldmethod = 'indent'
vim.opt.foldlevel = 99
-- also allow me to see the doc strings
vim.g.SimpylFold_docstring_preview=1
-- enable folding for markdown?
vim.g.markdown_folding = 1
vim.g.indentLine_fileTypeExclude = [['dashboard']]

-- let spacebar allow me to fold the code
-- nnoremap <space> za
vim.keymap.set('n', '<space>', 'za')

-- both of these are required to make packer, our plugin manager work
require('plugins')
vim.cmd [[source ~/.config/nvim/packerinit.vim]]

-- Colors need to be enabled after the plugins, because the colors are a plugin
vim.cmd [[colorscheme spacechalk]]

-- --------- these are plugin configs for plugins imported by packer ---------
require('user.airline')
require('user.dashboard')
