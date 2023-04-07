return {
    'nvim-telescope/telescope.nvim',
    keys = {
        { "<leader>tf","<CMD>Telescope find_files<CR>"},
        { "<leader>tg","<CMD>Telescope live_grep<CR>"},
        { "<C-r>","<CMD>Telescope registers<CR>", mode = "i" },
        { "<leader>tb","<CMD>Telescope builtin<CR>"},
        { "<leader>tg","<CMD>Telescope live_grep<CR>"},
    },
    cmd = { "Telescope" },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local builtin = require('telescope.builtin')
        local themes = require('telescope.themes')
        require('telescope').setup({
            defaults = {
                layout_strategy='horizontal',
                layout_config={
                    prompt_position='top',
                },
                sorting_strategy = "ascending",
                color_devicons = true,
                vimgrep_arguments = {
                    "rg",
                    "-L",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                },
                prompt_prefix = "   ",
                initial_mode = "insert",
                extensions_list = { "themes", "terms" },
                border = {},
                selection_strategy = "reset",
            }
        })
    end
}
