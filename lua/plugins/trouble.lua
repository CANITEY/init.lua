-- A pretty list for showing diagnostics, references, telescope results, quickfix and location lists to help you solve all the trouble your code is causing.

return {
    'folke/trouble.nvim',
    event = {'BufReadPre', 'BufNewFile'},
    keys = {
        { "<leader>tr","<CMD>TroubleToggle<CR>"},
    },
    opts = {

    },
}
