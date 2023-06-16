-- installing lsp-zero
return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' },
        {
            'williamboman/mason.nvim',
            build = function()
                pcall(vim.cmd, 'MasonUpdate')
            end,
            config = function ()
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
        { 'williamboman/mason-lspconfig.nvim' },

        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'L3MON4D3/LuaSnip' },
        { 'onsails/lspkind.nvim' },
        {'ray-x/lsp_signature.nvim'},
    },
    config = function()
        -- initializing
        local lsp = require('lsp-zero')
        lsp.preset({
            name = 'recommended',
        })
        lsp.on_attach(function(client, bufnr)
            lsp.default_keymaps({ buffer = bufnr })
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

        -- cmp configuration
        local cmp = require('cmp')
        local cmp_select = {behavior = cmp.SelectBehavior.Select}
        local cmp_action = require('lsp-zero').cmp_action()
        local luasnip = require("luasnip")
        require('luasnip.loaders.from_vscode').lazy_load()

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
                ['<CR>'] = cmp.mapping.confirm({select = false}),
                ['<C-y>'] = cmp.mapping.confirm({select = false}),
                ['<C-p>'] = cmp.mapping.select_prev_item({cmp_select}),
				['<C-n>'] = cmp.mapping.select_next_item({cmp_select}),
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
                ['<S-TAB>'] = cmp.mapping(function (fallback)
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
                fields = {'kind', 'abbr', 'menu'},
                format = require('lspkind').cmp_format({
                  mode = 'symbol', -- show only symbol annotations symbol_text|| text
                  maxwidth = 15, -- prevent the popup from showing more than provided characters
                  ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
                })
            }
        })
        -- end cmp configuration

        -- lsp signature config
        -- TOOD
    end
}
