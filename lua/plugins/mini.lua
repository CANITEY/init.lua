return {
    'echasnovski/mini.nvim',
    -- event = {'BufReadPre', 'BufNewFile'},
    lazy = true,
    config = function()
        require('mini.indentscope').setup({
            draw = {
                -- Delay (in ms) between event and start of drawing scope indicator
                delay = 30,
                -- Symbol priority. Increase to display on top of more symbols.
                priority = 2,
            },
            symbol = "│",
            options = {
                border = 'bottom',
            }
        })
    end
}
