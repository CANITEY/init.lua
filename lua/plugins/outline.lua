return {
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = { 
        { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
    },
    config = function()
        require('outline').setup({
            outline_window = {
                show_numbers = true,
                show_relative_numbers = true,
            },
            providers = {
                priority = { 'lsp', 'treesitter', 'markdown', 'norg' },
                lsp = {
                    -- Lsp client names to ignore
                    blacklist_clients = {},
                },
            },
        })
    end,
}
