return{
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        lazy = true,
        config = function()
            -- This is where you modify the settings for lsp-zero
            -- Note: autocompletion settings will not take effect

            require('lsp-zero.settings').preset({
                name = 'recommended',
            })
        end
    },

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            {
                'L3MON4D3/LuaSnip',
                build = "make install_jsregexp",
                dependencies = { "rafamadriz/friendly-snippets","saadparwaiz1/cmp_luasnip" },
            },
            {'onsails/lspkind.nvim'},

        },
        config = function()
            -- Here is where you configure the autocompletion settings.
            -- The arguments for .extend() have the same shape as `manage_nvim_cmp`: 
            -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/api-reference.md#manage_nvim_cmp

            require('lsp-zero.cmp').extend()

            -- And you can configure cmp even more, if you want to.
            local cmp = require('cmp')
            -- local cmp_action = require('lsp-zero.cmp').action()
            local luasnip = require("luasnip")
            local s = luasnip.snippet
            local sn = luasnip.snippet_node
            local t = luasnip.text_node
            local i = luasnip.insert_node
            local f = luasnip.function_node
            local c = luasnip.choice_node
            local d = luasnip.dynamic_node
            local r = luasnip.restore_node

            luasnip.add_snippets("go", {
                s("iferr", {
                    t({"if err != nil {", "\tpanic(err)","}"})
                }),
                s("decover", {
                    t({"defer func() {", "\tif r := recover(); r != nil {","\t\t"}),
                    i(1, "handling method"),
                    t({"","\t}","}()"})
                })
            })
            require('luasnip.loaders.from_vscode').lazy_load()
            local cmp_action = require('lsp-zero.cmp').action()
            local cmp_select_opts = {behavior = cmp.SelectBehavior.Insert}
            cmp.setup({
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, vim_item)
                        local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
                        local strings = vim.split(kind.kind, "%s", { trimempty = true })
                        kind.kind = " " .. (strings[1] or "") .. " "
                        kind.menu = "    (" .. (strings[2] or "") .. ")"
                        return kind
                    end,
                },
                select_behavior = cmp.SelectBehavior.insert,
                preselect = cmp.PreselectMode.None,
                completion = {
                    completeopt = 'menu,menuone,preview,noselect',
                },
                sources = {
                    { name = 'nvim_lsp_signature_help' },
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
                -- key mappings
                mapping = cmp.mapping.preset.insert({
                    ['<CR>'] = cmp.mapping.confirm({ select = false }),
                    ['<C-y>'] = cmp.mapping.confirm({ select = false }),
                    ['<C-n>'] = cmp.mapping(function()
                        if cmp.visible() then
                            cmp.select_next_item(cmp_select_opts)
                        else
                            cmp.complete()
                        end
                    end),
                    ['<C-p>'] = cmp.mapping(function()
                        if cmp.visible() then
                            cmp.select_prev_item(cmp_select_opts)
                        else
                            cmp.complete()
                        end
                    end),
                    -- end replace text on selection
                    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<TAB>'] = cmp.mapping(function(fallback)
                        if luasnip.expand_or_locally_jumpable() then
                            -- cmp_action.luasnip_jump_forward()
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
                }),
            })
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            cmp.event:on(
            'confirm_done',
            cmp_autopairs.on_confirm_done()
            )
        end
    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = 'LspInfo',
        event = {'BufReadPre', 'BufNewFile'},
        dependencies = {
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},
            {'williamboman/mason-lspconfig.nvim'},
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            {"hrsh7th/cmp-nvim-lsp-signature-help"},
            {
                'williamboman/mason.nvim',
                build = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
        },
        config = function()
            -- This is where all the LSP shenanigans will live

            local lsp = require('lsp-zero')

            lsp.on_attach(function(client, bufnr)
                lsp.default_keymaps({buffer = bufnr})
                local opts = { buffer = bufnr }
                vim.keymap.set({ 'n', 'x' }, '<F3>', function()
                    vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
                end, opts)

            end)
            -- (Optional) Configure lua language server for neovim
            require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            require'lspconfig'.clangd.setup {
              capabilities = capabilities,
            }
            lsp.set_sign_icons({
                error = '✘',
                warn = '▲',
                hint = '⚑',
                info = '»'
            })

            lsp.setup()
        end
    }
}
