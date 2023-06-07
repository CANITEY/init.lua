return {
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		dependencies = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},             -- Required
			{'williamboman/mason.nvim'},           -- Optional
			{'williamboman/mason-lspconfig.nvim'}, -- Optional

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},         -- Required
            {'hrsh7th/cmp-nvim-lsp'},     -- Required
            {'hrsh7th/cmp-buffer'},       -- Optional
            {'hrsh7th/cmp-path'},         -- Optional
            {'saadparwaiz1/cmp_luasnip'}, -- Optional
            {'hrsh7th/cmp-nvim-lua'},
            -- Snippets
            {'L3MON4D3/LuaSnip'},             -- Required
            {'rafamadriz/friendly-snippets'},
            {'ray-x/lsp_signature.nvim'},
            {'onsails/lspkind.nvim'},
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

            local cfg = {
                bind = true,
                doc_lines = 0,
                max_height = 4,
                hint_prefix = "",
                handler_opts = {
                        border = "rounded"   -- double, rounded, single, shadow, none, or a table of borders
                      },
                floating_window = false,
                toggle_key = '<C-k>',
                hint_enable = false,
                floating_window_off_x = 1, -- adjust float windows x position.
                floating_window_off_y = 0,
--                floating_window_off_y = function() -- adjust float windows y position. e.g. set to -2 can make floating window move up 2 lines
--                    local linenr = vim.api.nvim_win_get_cursor(0)[1] -- buf line number
--                    local pumheight = vim.o.pumheight
--                    local winline = vim.fn.winline() -- line number in the window
--                    local winheight = vim.fn.winheight(0)
--
--                    -- window top
--                    if winline - 1 < pumheight then
--                        return pumheight
--                    end
--
--                    -- window bottom
--                    if winheight - winline < pumheight then
--                        return -pumheight
--                    end
--                    return 0
--                end,
            } -- lsp_signature config
            require "lsp_signature".setup(cfg)

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
                sources = {
                    { name = 'nvim_lua' },
                    { name = 'nvim_lsp' }
                },
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

            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            require'lspconfig'.clangd.setup {
              capabilities = capabilities,
            }

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

            cmp.setup({
              formatting = {
                fields = {'abbr', 'kind', 'menu'},
                format = require('lspkind').cmp_format({
                  mode = 'symbol_text', -- show only symbol annotations
                  maxwidth = 25, -- prevent the popup from showing more than provided characters
                  ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
                })
              },
              format = function(entry, item)
                  local menu_icon = {
                      nvim_lsp = 'λ',
                      luasnip = '⋗',
                      buffer = 'Ω',
                      path = '🖫',
                      nvim_lua = 'Π',
                  }

                  item.menu = menu_icon[entry.source.name]
                  return item
              end,
          })
		end
	}
}
