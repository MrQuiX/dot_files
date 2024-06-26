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

-- vim.opt.termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- make searching case insensitive
vim.opt.ignorecase = true
-- make searching case sensitive if at least one character is cap
vim.opt.smartcase = true

-- load plugins
require('user.lazy')

-- --------- Plugin configs that have to be called after lazy --------------
-- starting page for neovim - dashbaord plugin
require('user.dashboard')

-- tab line at top of window for tabs when there's more than one tab :) -- might switch to bufferline
require('user.barbar')

-- status line at bottom of window for cool file facts
require('user.lualine')

-- directory tree; can open with :Neotree
require('user.neo-tree')

-- scrollbar on the right side of the screen that also shows errors
require("user.gitsigns")
require("user.scrollbar")

-- more configurable terminal for neovim
require("user.toggleterm")

-- Language Server configs and other syntax checking and highlight tools
require('user.lsp-configs')

-- Language server configs for stuff that doesn't have it
require('user.null_ls')

-- autocommand to disable lsp semantic highlighting for parameter/variable in
-- Dockerfile because it competes with treesitter and is worse
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = {"Dockerfile", "Dockerfile.*"},
  callback = function()
        vim.api.nvim_set_hl(0, '@lsp.type.parameter.dockerfile', {})
        vim.api.nvim_set_hl(0, '@lsp.type.variable.dockerfile', {})
    end,
})

-- autocommand to set the file type to helm based on files ending in tpl
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = {
        "*/templates/*.tpl",
        "*/templates/*.yaml",
        "*/.github/workflows/*.yaml",
        "*/.github/workflows/*.yml",
    },
  callback = function()
        vim.cmd("set filetype=helm")
    end,
})

-- autocommand to set the file type to cfg for wireguard configs
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = {"*/etc/wireguard/wg*.conf"},
  callback = function()
        vim.cmd("set filetype=cfg")
    end,
})

-- autocommand to set the file type to yaml for kubeconfig
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = {"*/kubeconfig", "*/.config/kube/config"},
  callback = function()
        vim.cmd("set filetype=yaml")
    end,
})

-- autocommand to set the file type to css for tcss
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = {"*.tcss"},
  callback = function()
        vim.cmd("set filetype=scss")
        vim.cmd("set foldmethod=indent")
    end,
})

-- autocommand to only set 81 character line limit on python, go, yaml, and shell scripts
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = {"*.py", "*.go", "*.yaml", "*.sh"},
  callback = function()
        -- highlighted column 81, to keep lines to average terminal size
        vim.opt.colorcolumn = '81'
    end,
})

-- autocommand to only set 81 character line limit on python, go, yaml, and shell scripts
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = {"*.txt", "*.md", "*.mdx"},
  callback = function()
        vim.cmd("set spell")
    end,
})

-- delete whitespace on save - https://vi.stackexchange.com/a/41388
vim.api.nvim_create_autocmd({ "BufWritePre", "ExitPre" }, {
    pattern = {"*"},
    callback = function()
      local save_cursor = vim.fn.getpos(".")
      pcall(function() vim.cmd [[%s/\s\+$//e]] end)
      vim.fn.setpos(".", save_cursor)
    end,
})

require('user.tree-sitter')

-- folding and indentation
require('user.indent')

-- completion from nvim-cmp
require('user.completion')

-- syntax highlighting for hex codes
require('user.nvim-colorizer')

-- experiment to give you a remote git permalink URL for your your current line
-- require('user.git_url')
