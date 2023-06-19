-- to define my clipboard in advance to make neovim faster
vim.g.clipboard = {
 name = "xsel",
 copy = {
  ["+"] = "xsel --nodetach -i -b",
  ["*"] = "xsel --nodetach -i -p",
 },
 paste = {
  ["+"] = "xsel  -o -b",
  ["*"] = "xsel  -o -b",
 },
 cache_enabled = 1,
}
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.smartindent = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.showmode = false
vim.wo.fillchars = 'eob: ,vert:|'
vim.cmd[[set clipboard+=unnamedplus]]
