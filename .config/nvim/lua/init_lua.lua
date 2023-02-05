local M = {}

M.setup = function()

    require("todo-comments").setup()
    require("nvim-tree").setup()

    require'nvim-treesitter.configs'.setup {
      -- A list of parser names, or "all"
      ensure_installed = { "c", "lua",},
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,
      highlight = {
        enable = true,
        disable = function(lang, buf)
            local max_filesize = 500 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = true,
      },
    }


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

    local fb_actions = require"telescope".extensions.file_browser.actions
    -- Telescope setup
    local actions = require("telescope.actions")
    require("telescope").setup({
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            },
            file_browser = {
                respect_gitignore = false,
            },
        },
        pickers = {
            colorscheme = {
                enable_preview = true
            }
        },
        defaults = {
            mappings = {
                i = {
                    ["<C-i>"] = fb_actions.toggle_hidden,
                    ["<C-h>"] = fb_actions.goto_parent_dir,
                    ["<C-l>"] = actions.select_default,
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,
                    ["<esc>"] = actions.close,
                    ["<C-l>"] = actions.select_default,
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

    --local neogit = require('neogit')
    --neogit.setup {}

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
            ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item()),
            ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item()),
        },
    })
    require('leap').add_default_mappings()

    require("noice").setup({
        excluded_filetypes = { "cmp_menu", "cmp_docs", "notify" },
        views = {
            messages = {

            },
            cmdline_popup = {
                position = {
                    row = 20,
                    col = "50%",
                },
                size = {
                    width = 200,
                    height = "auto",
                },
            },
            lsp = {
                hover = {
                    enabled = true,
                },
                documentation = {
                    view = "hover",
                    ---@type NoiceViewOptions
                    opts = {
                        lang = "markdown",
                        replace = true,
                        render = "plain",
                        format = { "{message}" },
                        win_options = { concealcursor = "n", conceallevel = 3 },
                    },
                },
            },
            popupmenu = {
                relative = "editor",
                position = {
                    row = 20,
                    col = "50%",
                },
                size = {
                    width = 200,
                    height = 10,
                },
                border = {
                    style = "rounded",
                    padding = { 0, 1 },
                },
                win_options = {
                    winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
                },
            },
        },
    })

    require('notify').setup({
        render = "minimal", 
        stages = "slide",
        fps    = 60,
        
    })

    require('sniprun').setup({
        display = {"NvimNotify"},
    })

    require("catppuccin").setup {
        flavour = "frappe" -- mocha, macchiato, frappe, lattec
    }

    require('windows').setup({
        autowidth = {
            enable = true,
            winwidth = 50,
        },
        ignore = {
            buftype = { "quickfix", "Telescope", "telescope"},
            filetype = { "NvimTree", "neo-tree", "undotree", "gundo", "Telescope", "telescope", }
        },

        animation = {
            enable = false,
            duration = 300,
            fps = 60,
            easing = "in_out_sine"
        }
    })

    local header_art = 
    [[
    ╭╮╭┬─╮╭─╮┬  ┬┬╭┬╮
    │││├┤ │ │╰┐┌╯││││
    ╯╰╯╰─╯╰─╯ ╰╯ ┴┴ ┴
    ]]

    --require('mini.nvim').setup({
        local starter = require'mini.starter'
        starter.setup {
            items = {
                starter.sections.telescope(),
            },
            content_hooks = {
                starter.gen_hook.adding_bullet(),
                starter.gen_hook.aligning("center", "center"),
            },
            header = header_art
        }

        require('toggleterm').setup({
            autochdir = true,
            direction = 'float',
        })

        local colorpicker = require('color-picker')
        colorpicker.setup()
end

require('telescope').load_extension('fzf')

function _G.Toggle_venn()
    local venn_enabled = vim.inspect(vim.b.venn_enabled)
    if venn_enabled == "nil" then
        vim.b.venn_enabled = true
        vim.cmd[[setlocal ve=all]]
        -- draw a line on HJKL keystokes
        vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", {noremap = true})
        -- draw a box by pressing "f" with visual selection
        vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", {noremap = true})
    else
        vim.cmd[[setlocal ve=]]
        vim.cmd[[mapclear <buffer>]]
        vim.b.venn_enabled = nil
    end

end


-- toggle keymappings for venn using <leader>v
vim.api.nvim_set_keymap('n', '<leader>v', ":lua Toggle_venn()<CR>", { noremap = true})

require('neoscroll').setup()

return M
