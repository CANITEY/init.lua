return {
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v1.x',
		dependencies = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},             -- Required
			{'williamboman/mason.nvim'},           -- Optional
			{'williamboman/mason-lspconfig.nvim'}, -- Optional

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},         -- Required
            {'hrsh7th/cmp-nvim-lsp'},     -- Required
            {'hrsh7th/cmp-nvim-lsp'},     -- Required
            {'hrsh7th/cmp-buffer'},       -- Optional
            {'hrsh7th/cmp-path'},         -- Optional
            {'saadparwaiz1/cmp_luasnip'}, -- Optional
            {'hrsh7th/cmp-nvim-lua'}, 
            -- Snippets
            {'L3MON4D3/LuaSnip'},             -- Required
            {'rafamadriz/friendly-snippets'},
            { 'ray-x/lsp_signature.nvim' },
		},
		config = function()

			local lsp = require("lsp-zero")
			local luasnip = require("luasnip")
			lsp.preset("recommended")
			lsp.configure('lua-language-server', {
				settings = {
					Lua = {
						diagnostics = {
							globals = { 'vim' }
						}
					}
				}
			})

            local cfg = {} -- lsp_signature config
            require "lsp_signature".setup()




			local cmp = require('cmp')
			local cmp_select = {behavior = cmp.SelectBehavior.Select}
			local cmp_mappings = lsp.defaults.cmp_mappings({
				['<C-p>'] = cmp.mapping.select_prev_item({cmp_select}),
				['<C-n>'] = cmp.mapping.select_next_item({cmp_select}),
				['<C-y>'] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = false,
				}),
				["<C-Space>"] = cmp.mapping.complete(),
				['<C-e>'] = cmp.mapping.abort(),
				["<C-d>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<CR>"] = cmp.mapping.confirm {
					behavior = cmp.ConfirmBehavior.Replace,
					select = false,
				},
				['<S-Tab>'] = cmp.mapping(function (fallback)
					if luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end
				),
				['<Tab>'] = cmp.mapping(function(fallback)
					if luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end
				)

			})
			local cmp_config = lsp.defaults.cmp_config({
				window = {
					completion = cmp.config.window.bordered()
				}
			})


            cmp.setup({
                preselect = cmp.PreselectMode.Item,
                completion = {
                    completeopt = 'menu,menuone,noinsert'
                },
				window = {
					completion = cmp.config.window.bordered()
				}
            })

			lsp.setup_nvim_cmp({
				mapping = cmp_mappings,
				preselect = 'none',
				completion = {
					completeopt = 'menu,menuone,noinsert,noselect'
				},
			})

			lsp.set_preferences({
				suggest_lsp_servers = false,
				sign_icons = {
					error = 'E',
					warn = 'W',
					hint = 'H',
					info = 'I'
				}
			})

			lsp.on_attach(function(client, bufnr)
				local opts = {buffer = bufnr, remap = false}
				vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
				vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
				vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
			end)

			lsp.setup()

			vim.diagnostic.config({
				virtual_text = true
			})

		end
	}
}
