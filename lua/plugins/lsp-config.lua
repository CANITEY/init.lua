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
                error = 'X',
                warn = '▲',
                hint = '⚑',
                info = '»'
            })

            -- (Optional) Configure lua language server for neovim
            require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
            lsp.setup()
            -- end initializing

            -- lsp signature config
            -- TOOD
        end,
        dependencies = {
            {'hrsh7th/cmp-nvim-lsp'},
            {'williamboman/mason-lspconfig.nvim'},
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            {
                'williamboman/mason.nvim',
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
            {'L3MON4D3/LuaSnip'},
            { 'onsails/lspkind.nvim' },
            { 'ray-x/lsp_signature.nvim' },
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
            local cmp = require('cmp')
            cmp.event:on(
            'confirm_done',
            cmp_autopairs.on_confirm_done()
            )
            cmp.setup({
                sources = {
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
                        if luasnip.expand_or_jumpable() then
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
        end

    },
}
