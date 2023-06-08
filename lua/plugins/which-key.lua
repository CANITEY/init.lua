-- plugin to show keys pressed

return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 100
        end,
        opts = {
            window = {
                border = "single", -- none, single, double, shadow
            }
        },
        config = function ()
            local which_key = require("which-key")
            which_key.register(
            {
                t = {
                    name = 'Telescope',
                    {
                        f = {"Find File"},
                        b = {"Built-ins"},
                        g = {"Live Grep"},
                        r = {"Registers"},
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
            { prefix = "<leader>" }
            )

    end
    }

}
