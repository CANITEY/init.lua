-- plugin to show keys pressed

return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            window = {
                border = "single", -- none, single, double, shadow
            }
        },
        init = function ()
            vim.o.timeout = true
            vim.o.timeoutlen = 150
            local which_key = require("which-key")
            which_key.register({
                    t = {
                        name = 'Telescope',
                        {
                            f = {"Find File"},
                            b = {"Built-ins"},
                            g = {"Live Grep"},
                            r = {"Trouble"},
                            c = {"colorschemes"},
                        }
                    },
                    u = "Undo Tree",
                    d = "Tree",
                    h = "Horizontal Terminal",
                    v = "Vertical Terminal",
                    f = "Floating Terminal",
                    w = "Close Buffer",
                    n = "Next Buffer",
                    p = "Previous Buffer",
                    ["1"] = "which_key_ignore",
                    tw = {"<cmd>WhichKey<cr>", "Show keymaps"},
                },
                { prefix = "<leader>" },
                { mode = "n" }
            )
            which_key.register({
                g = {
                    name = "comment",
                    {
                        c = { "line comment" },
                        b = { "block comment" },
                    }
                },
            },
            { mode = 'v' }
            )
    end
    }
}
