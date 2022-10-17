local M = {}

M.setup = function()
    local lsp = require('lsp-zero')

    lsp.set_preferences({
        suggest_lsp_servers = true,
        setup_servers_on_start = true,
        set_lsp_keymaps = false,
        configure_diagnostics = true,
        cmp_capabilities = true,
        manage_nvim_cmp = true,
        call_servers = 'local',
        sign_icons = {
            error = '✘',
            warn = '▲',
            hint = '⚑',
            info = ''
        }
    })

    --lsp.preset('recommended')
    lsp.setup()

    -- Hop
    require'hop'.setup()

    -- Telescope setup
    local actions = require("telescope.actions")
    require("telescope").setup({
        pickers = {
            colorscheme = {
                enable_preview = true
            }
        },
        defaults = {
            mappings = {
                i = {
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,
                    ["<esc>"] = actions.close,
                },
            },

            --layout_strategy = "vertical",
            layout_config = {
                preview_cutoff = 20,
            },
        },
    })


    -- File browser with telescope
    require("telescope").load_extension "file_browser"

    -- Which-key / preview commands in popup buffer
    require("which-key").setup {}

    -- Yanky / Yank history
    require("yanky").setup({
        highlight = {
            on_put = false,
            on_yank = false,
            timer = 500,
        }
    })
    require("telescope").load_extension("yank_history")

    -- Lualine
    require('lualine').setup()

    -- Harpoon
    require("telescope").load_extension('harpoon')

    local neogit = require('neogit')
    neogit.setup {}

    -- cmp setup
    local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local luasnip = require("luasnip")
    local cmp = require("cmp")
    cmp.setup({
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

            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { "i", "s" }),
        },
    })

end
return M
