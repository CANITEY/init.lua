return {
    {
        'luisiacc/gruvbox-baby',
        lazy = true,
      cmd = "Telescope colorscheme",
        config = function()
            -- Example config in Lua
            vim.g.gruvbox_baby_function_style = "bold"
            vim.g.gruvbox_baby_comment_style = "italic"
            vim.g.gruvbox_baby_keyword_style = "italic"
            -- Enable telescope theme
            vim.g.gruvbox_baby_telescope_theme = 1

            -- Enable transparent mode
            vim.g.gruvbox_baby_transparent_mode = 0
        end
    }
}
