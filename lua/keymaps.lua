vim.g.mapleader = " "
vim.keymap.set("n", "<leader>n", vim.cmd.bn)
vim.keymap.set("n", "<leader>p", vim.cmd.bp)
vim.keymap.set("n", "<leader>w", vim.cmd.bd)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set('n', '<UP>', vim.cmd[[]])
vim.keymap.set('n', '<RIGHT>', vim.cmd[[]])
vim.keymap.set('n', '<LEFT>', vim.cmd[[]])
vim.keymap.set('n', '<DOWN>', vim.cmd[[]])

-- move freely within insert mode
vim.keymap.set('i', '<A-k>', '<UP>')
vim.keymap.set('i', '<A-j>', '<DOWN>')
vim.keymap.set('i', '<A-l>', '<RIGHT>')
vim.keymap.set('i', '<A-h>', '<LEFT>')

-- noh and escape
vim.keymap.set('n', '<ESC>', vim.cmd.noh)

-- switch between buffers in insert mode
vim.keymap.set('i', '<C-b>n', vim.cmd.bn)
vim.keymap.set('i', '<C-b>p', vim.cmd.bp)
