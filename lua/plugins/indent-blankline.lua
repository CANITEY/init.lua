return {
    'echasnovski/mini.nvim',
    config = function()
        require('mini.indentscope').setup({
            draw = {
                -- Delay (in ms) between event and start of drawing scope indicator
                delay = 30,
                -- Symbol priority. Increase to display on top of more symbols.
                priority = 2,
            },
        })
    end
}
