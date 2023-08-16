return {
    'nvim-telescope/telescope.nvim',
    keys = {
        { "<leader>tf","<CMD>Telescope find_files<CR>"},
        { "<leader>tg","<CMD>Telescope live_grep<CR>"},
        { "<C-r>","<CMD>Telescope registers<CR>", mode = "i" },
        { "<leader>tb","<CMD>Telescope builtin<CR>"},
        { "<leader>tg","<CMD>Telescope live_grep<CR>"},
        { "<leader>u","<CMD>Telescope undo<CR>"},
        { "<leader>tc","<CMD>lua require('telescope.builtin').colorscheme({enable_preview = true,})<CR>", "colorschemes"},
    },
    cmd = { "Telescope" },
    dependencies = {
        'nvim-lua/plenary.nvim',
        'debugloop/telescope-undo.nvim',
    },
    config = function()
        local builtin = require('telescope.builtin')
        local themes = require('telescope.themes')
        require('telescope').setup({
            pickers = {
                colorscheme = {
                    enable_preview = true,
                }
            },
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
                border = {},
                selection_strategy = "reset",
            },
            extensions = {
                undo = {
                    mappings = {
                        i = {
                            ["<CR>"] = require("telescope-undo.actions").restore,
                        },
                    },
                },
            },
        })
        require("telescope").load_extension("undo")
        vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
    end
}
