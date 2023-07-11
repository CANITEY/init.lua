-- installing lsp-zero
return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        lazy = true,
    },
    -- LSP Support
    { 
        'neovim/nvim-lspconfig',
        cmd = 'LspInfo',
        event = {'BufReadPre', 'BufNewFile'},
        config = function()
            -- initializing
            local lsp = require('lsp-zero')
            lsp.preset({
                name = 'recommended',
            })
            lsp.setup_nvim_cmp({
                preselect = 'none',
                completion = {
                    completeopt = 'menu,menuone,noinsert,noselect'
                },
            })
            lsp.on_attach(function(client, bufnr)
                lsp.default_keymaps({ buffer = bufnr })
                -- formate on keybinding
                local opts = { buffer = bufnr }
                vim.keymap.set({ 'n', 'x' }, '<F3>', function()
                    vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
                end, opts)
            end)

            -- icons on diagnostics
            lsp.set_sign_icons({
                error = '✘',
                warn = '▲',
                hint = '⚑',
                info = '»'
            })

            -- (Optional) Configure lua language server for neovim
            require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
            lsp.setup()
            -- end initializing
        end,
        dependencies = {
            {'hrsh7th/cmp-nvim-lsp'},
            {'williamboman/mason-lspconfig.nvim'},
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            {
                'williamboman/mason.nvim',
                cmd = "Mason",
                build = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
                config = function()
                    require("mason").setup({
                        ui = {
                            icons = {
                                package_installed = "✓",
                                package_pending = "➜",
                                package_uninstalled = "✗"
                            },
                            border = "rounded",
                        }
                    })
                end
            },
        },
    },

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        event = "InsertEnter",
        dependencies = {
            {
                'L3MON4D3/LuaSnip',
                build = "make install_jsregexp",
                dependencies = { "rafamadriz/friendly-snippets","saadparwaiz1/cmp_luasnip" },

            },
            { 'onsails/lspkind.nvim' },
            { 'ray-x/lsp_signature.nvim' },
            { 'hrsh7th/cmp-nvim-lua' },
        },
        config = function()
            -- cmp configuration
            local lspkind = require('lspkind')
            local cmp = require('cmp')
            local cmp_select = { behavior = cmp.SelectBehavior.Select }
            local cmp_action = require('lsp-zero').cmp_action()
            local luasnip = require("luasnip")
            require('luasnip.loaders.from_vscode').lazy_load()
            -- If you want insert `(` after select function or method item
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            cmp.event:on(
            'confirm_done',
            cmp_autopairs.on_confirm_done()
            )
            cmp.setup({
                sources = {
                    { name = 'nvim_lua' },
                    { name = 'path' },
                    { name = 'nvim_lsp' },
                    { name = 'buffer',  keyword_length = 3 },
                    { name = 'luasnip', keyword_length = 2 },
                },

                -- decorating complete menu
                window = {
                    completion = cmp.config.window.bordered('double'),
                    documentation = cmp.config.window.bordered(),
                },
                -- replace text on selection
                preselect = cmp.PreselectMode.None,
                completion = {
                    completeopt = 'menu,menuone,noinsert'
                },
                -- key mappings
                mapping = {
                    ['<CR>'] = cmp.mapping.confirm({ select = false }),
                    ['<C-y>'] = cmp.mapping.confirm({ select = false }),
                    ['<C-p>'] = cmp.mapping.select_prev_item({ cmp_select }),
                    ['<C-n>'] = cmp.mapping.select_next_item({ cmp_select }),
                    -- end replace text on selection
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<TAB>'] = cmp.mapping(function(fallback)
                        if luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end),
                    ['<S-TAB>'] = cmp.mapping(function(fallback)
                        if luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end
                    )
                },
                -- end key mappings
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, vim_item)
                        local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
                        local strings = vim.split(kind.kind, "%s", { trimempty = true })
                        kind.kind = " " .. (strings[1] or "") .. " "
                        kind.menu = "    (" .. (strings[2] or "") .. ")"
                        return kind
                    end,
                }
            })
            -- end cmp configuration
            -- config lsp-signature
            cfg = {
                debug = false, -- set to true to enable debug logging
                log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
                -- default is  ~/.cache/nvim/lsp_signature.log
                verbose = false, -- show debug line number

                bind = true, -- This is mandatory, otherwise border config won't get registered.
                -- If you want to hook lspsaga or other signature handler, pls set to false
                doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
                -- set to 0 if you DO NOT want any API comments be shown
                -- This setting only take effect in insert mode, it does not affect signature help in normal
                -- mode, 10 by default

                max_height = 12, -- max height of signature floating_window
                max_width = 80, -- max_width of signature floating_window
                noice = false, -- set to true if you using noice to render markdown
                wrap = true, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long

                floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

                floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
                -- will set to true when fully tested, set to false will use whichever side has more space
                -- this setting will be helpful if you do not want the PUM and floating win overlap

                floating_window_off_x = 1, -- adjust float windows x position. 
                -- can be either a number or function
                floating_window_off_y = function() -- adjust float windows y position. e.g. set to -2 can make floating window move up 2 lines
                    local linenr = vim.api.nvim_win_get_cursor(0)[1] -- buf line number
                    local pumheight = vim.o.pumheight
                    local winline = vim.fn.winline() -- line number in the window
                    local winheight = vim.fn.winheight(0)

                    -- window top
                    if winline - 1 < pumheight then
                        return pumheight
                    end

                    -- window bottom
                    if winheight - winline < pumheight then
                        return -pumheight
                    end
                    return 0
                end, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines

                close_timeout = 4000, -- close floating window after ms when laster parameter is entered
                fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
                hint_enable = false, -- virtual hint enable
                hint_prefix = "",  -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
                hint_scheme = "String",
                hint_inline = function() return false end,  -- should the hint be inline(nvim 0.10 only)?  default false
                hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
                handler_opts = {
                    border = "rounded"   -- double, rounded, single, shadow, none, or a table of borders
                },

                always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

                auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
                extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
                zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

                padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc

                transparency = nil, -- disabled by default, allow floating win transparent value 1~100
                shadow_blend = 36, -- if you using shadow as border use this set the opacity
                shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
                timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
                toggle_key = nil, -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
                toggle_key_flip_floatwin_setting = false, -- true: toggle float setting after toggle key pressed

                select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' function overloading
                move_cursor_key = nil, -- imap, use nvim_set_current_win to move cursor between current win and floating
            }
            require "lsp_signature".setup(cfg)
        end

    },
}
