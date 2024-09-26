return {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-nvim-lsp',
    'L3MON4D3/LuaSnip',
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},
    {
        'VonHeikemen/lsp-zero.nvim', 
        branch = 'v3.x',
        config = function()
            local lsp_zero = require('lsp-zero')
            local lspconfig = require('lspconfig')

            lsp_zero.on_attach(function(client, bufnr)
                lsp_zero.default_keymaps({buffer = bufnr})
            end)

            require('mason').setup()
            require('mason-lspconfig').setup({
                ensure_installed = {'dartls'},
                handlers = {
                    lsp_zero.default_setup,
                    dartls = function()
                        lspconfig.dartls.setup({
                            on_attach = lsp_zero.on_attach,
                            capabilities = lsp_zero.get_capabilities(),
                            cmd = {"dart", "language-server", "--protocol=lsp"},
                            filetypes = {"dart"},
                            init_options = {
                                closingLabels = true,
                                flutterOutline = true,
                                onlyAnalyzeProjectsWithOpenFiles = true,
                                outline = true,
                                suggestFromUnimportedLibraries = true
                            },
                            settings = {
                                dart = {
                                    completeFunctionCalls = true,
                                    showTodos = true,
                                }
                            }
                        })
                    end,
                },
            })
            lspconfig.dartls.setup{}
        end
    },
    {'neovim/nvim-lspconfig'},
    {
        'hrsh7th/nvim-cmp',
        config = function ()
            local has_words_before = function()
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            local luasnip = require("luasnip")
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = {
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<CR>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item()),
                    ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item()),
                },
                sources = {
                    {name = 'path'},
                    {name = 'nvim_lsp'},
                    {name = 'buffer', keyword_length = 3},
                    {name = 'luasnip', keyword_length = 2},
                },
            })
        end,
    },
}
