local function vimIcon()
    return [[]]
end
local function kali()
    return [[ ]]
end

return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "kyazdani42/nvim-web-devicons"},
        Lazy = true,
        config = function()
            require('lualine').setup {
                extensions = {'trouble', 'oil', 'aerial'},
                options = {
                    icons_enabled = true,
                    theme = 'auto',
                    component_separators = { left = '', right = ''},
                    section_separators = { left = '', right = ''},
                    disabled_filetypes = {
                        statusline = { 'dashboard', 'NvimTree', 'NvTerm' },
                        winbar = { 'dashboard', 'NvimTree', 'NvTerm' }
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    globalstatus = false,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                    }
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch', 'diff', 'diagnostics'},
                    lualine_c = {'filename'},
                    lualine_x = {'encoding', kali, 'filetype'},
                    lualine_y = {'progress'},
                    lualine_z = {'location'}
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {'filename'},
                    lualine_x = {'location'},
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {
                    lualine_a = {
                        {
                            "buffers", 
                            show_filename_only = false,
                            use_mode_colors = true,
                        }
                    },
                    lualine_b = {"branch"},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {"tabs"},
                    lualine_z = {vimIcon}
                },
                winbar = {
                    lualine_b = {
                        '%F', 
                        { 
                            "aerial", 
                        },
                    }
                },
                inactive_winbar = {},
            }
        end

    }
}
