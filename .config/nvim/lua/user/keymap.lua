-- map leader to <Space>
vim.g.mapleader = " "

-- enter to fold code (collapses code block)
vim.keymap.set('n', '<enter>', 'za')

-- ---------------------- fterm windows ----------------------------
-- CTRL+t keybindings to toggle terminal
vim.keymap.set('n', '<C-t>', '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<C-t>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

-- cmatrix
vim.keymap.set('n', '<leader>M', '<cmd>Matrix<cr>', { desc = "c the matrix 󰘨 " })
-- gitui
vim.keymap.set('n', '<leader>g', '<cmd>Gitui<cr>', { desc = "Git TUI  " })
-- k9s
vim.keymap.set('n', '<leader>K', '<cmd>K9s<cr>', { desc = "k9s - kubernetes dashboard TUI 󱃾 " })

-- ---------------------- Telescope windows ----------------------------
vim.keymap.set('n', "<leader>:", "<cmd>Telescope commands<cr>", { desc = "All Commands" })
vim.keymap.set('n', '<leader>H', '<cmd>Telescope highlights<CR>', { desc = "Telescope for highlight groups in current buffer" })
vim.keymap.set('n', '<leader>h', '<cmd>Telescope command_history<CR>', { desc = "Telescope for command history" })
vim.keymap.set('n', "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files (cwd)" })
vim.keymap.set('n', "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Files Recently Opened in Neovim" })

-- --------------------------- Diagnostics ------------------------------
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
  {silent = true, noremap = true}
)