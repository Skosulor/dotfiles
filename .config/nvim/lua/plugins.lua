return {
    { "folke/neoconf.nvim", cmd = "Neoconf" },
    "folke/neodev.nvim",
    {
        'ziontee113/color-picker.nvim',
        config = function()
            local colorpicker = require('color-picker')
            colorpicker.setup()
        end,
    },
    {
        'nvim-telescope/telescope.nvim',
        lazy = false,
        version = '0.1.1',
        config = function()

            local fb_actions = require"telescope".extensions.file_browser.actions
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
                    border = {},
                    mappings = {

                        i = {
                            ["<C-i>"] = fb_actions.toggle_hidden,
                            ["<C-h>"] = fb_actions.goto_parent_dir,
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
            require("telescope").load_extension "file_browser"
        end,
    },

    {
        'echasnovski/mini.nvim',
        config = function()
            local header_art = 
            [[
╭╮╭╮╭╮╱╱╭╮
┃┃┃┃┃┃╱╱┃┃
┃┃┃┃┃┣━━┫┃╭━━┳━━┳╮╭┳━━╮
┃╰╯╰╯┃┃━┫┃┃╭━┫╭╮┃╰╯┃┃━┫
╰╮╭╮╭┫┃━┫╰┫╰━┫╰╯┃┃┃┃┃━┫
╱╰╯╰╯╰━━┻━┻━━┻━━┻┻┻┻━━╯
]]
            local header_art2 = 
            [[
            ╭╮╭┬─╮╭─╮┬  ┬┬╭┬╮
            │││├┤ │ │╰┐┌╯││││
            ╯╰╯╰─╯╰─╯ ╰╯ ┴┴ ┴
            ]]
            -- require('mini.sessions').setup()
            --require('mini.nvim').setup({
            local starter = require'mini.starter'
            starter.setup {
                items = {
                    starter.sections.telescope(),
                    {name = "One", action = ":e ~/one/one.norg", section = "Doc's"},
                    {name = "Plugins", action = ":e ~/.config/nvim/lua/plugins.lua", section = "Doc's"},
                    {name = "Init", action = ":e ~/.config/nvim/init.lua", section = "Doc's"},
                    starter.sections.recent_files(5, false),
                    -- starter.sections.sessions(5,false),
                    starter.sections.builtin_actions(),
                },
                content_hooks = {
                    starter.gen_hook.adding_bullet(),
                    starter.gen_hook.aligning("center", "center"),
                },
                header = header_art,
                footer = " ",
            }
        end,
    },

    {
        'akinsho/toggleterm.nvim',
        config = function()
            require('toggleterm').setup({
                autochdir = true,
                direction = 'float',
            })
        end,
    },
    'kevinhwang91/nvim-bqf',
    {
        'folke/todo-comments.nvim',
        config = function()
            require("todo-comments").setup()
        end,
    },
    {
        'nvim-tree/nvim-tree.lua',
        config = function()
            require("nvim-tree").setup()
        end,
    },
    {
        'anuvyklack/windows.nvim',
        config = function()
            require('windows').setup({
                autowidth = {
                    enable = true,
                    winwidth = 10,
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
        end,
    },
    'anuvyklack/middleclass',
    'anuvyklack/animation.nvim',

    {'L3MON4D3/LuaSnip'},

    -- 'rcarriga/nvim-notify',
    'MunifTanjim/nui.nvim',
    --{
    --    'folke/noice.nvim',
    --    config = function()
    --        require("noice").setup({
    --            excluded_filetypes = { "cmp_menu", "cmp_docs", "notify" },
    --            views = {
    --                messages = {

    --                },
    --                cmdline_popup = {
    --                    position = {
    --                        row = 20,
    --                        col = "50%",
    --                    },
    --                    size = {
    --                        width = 130,
    --                        height = "auto",
    --                    },
    --                },
    --                lsp = {
    --                    hover = {
    --                        enabled = true,
    --                    },
    --                    documentation = {
    --                        view = "hover",
    --                        ---@type NoiceViewOptions
    --                        opts = {
    --                            lang = "markdown",
    --                            replace = true,
    --                            render = "plain",
    --                            format = { "{message}" },
    --                            win_options = { concealcursor = "n", conceallevel = 3 },
    --                        },
    --                    },
    --                },
    --                popupmenu = {
    --                    relative = "editor",
    --                    position = {
    --                        row = 20,
    --                        col = "50%",
    --                    },
    --                    size = {
    --                        width = 130,
    --                        height = 10,
    --                    },
    --                    border = {
    --                        style = "rounded",
    --                        padding = { 0, 1 },
    --                    },
    --                    win_options = {
    --                        winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
    --                    },
    --                },
    --            },
    --        })

    --    end,
    --},
    {
        'ahmedkhalf/project.nvim',
        config = function()
            require('telescope').load_extension('projects')
            require("project_nvim").setup ({
                patterns = {'.git'},
            })
        end,

    },
    {
        -- 'karb94/neoscroll.nvim',
        -- config = function()
        --     require('neoscroll').setup()
        -- end,
    },
    'junegunn/vim-easy-align',

    {
        'nvim-telescope/telescope-fzf-native.nvim', 
        build = 'make',
        config = function ()
            require('telescope').load_extension('fzf')
        end,
    },

    {
        'ggandor/leap.nvim',
        config = function()
            require('leap').add_default_mappings()
        end,
    },

    'airblade/vim-gitgutter',
    'jiangmiao/auto-pairs',
    -- 'AckslD/nvim-whichkey-setup.lua',
    'tpope/vim-commentary',

     -- Git
    'sindrets/diffview.nvim',
    'tpope/vim-fugitive',
    'junegunn/gv.vim',

    -- Navigation
    {
        'folke/which-key.nvim',
        config = function ()
            require("which-key").setup {}
        end,
    },
    -- 'phaazon/hop.nvim',
    {
        'ThePrimeagen/harpoon',
        config = function ()
            require("harpoon").setup(
            {
                menu = {
                    width = 90,
                }
            })
            require("telescope").load_extension('harpoon')
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        config = function()
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
        end,
    },
    'nvim-treesitter/nvim-treesitter-context',
    'DanilaMihailov/beacon.nvim',
    'rhysd/clever-f.vim',

    -- Telescope
    'nvim-telescope/telescope-file-browser.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'sharkdp/fd',

    -- Lsp
    'neovim/nvim-lspconfig',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    {
        'VonHeikemen/lsp-zero.nvim',
        config = function()
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
        end,
    },

    -- Autocompletion
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
        end,
    },
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',

    -- Theming
    {
        'nvim-lualine/lualine.nvim',
        config = function ()
            require('lualine').setup()
        end,
    },
    {
        'navarasu/onedark.nvim',
        config = function()
            require('onedark').setup {
                style = 'dark'
            }
            vim.cmd([[colorscheme onedark]])
        end,
    },
    {
        'sainnhe/everforest',
        config = function()
        end,
    },
    {
 {
        "nvim-neorg/neorg",
        build = ":Neorg sync-parsers",
        opts = {
            load = {
                ["core.defaults"] = {}, -- Loads default behaviour
                ["core.norg.concealer"] = {}, -- Adds pretty icons to your documents
                ["core.norg.dirman"] = { -- Manages Neorg workspaces
                    config = {
                        workspaces = {
                            notes = "~/notes",
                        },
                    },
                },
            },
        },
        dependencies = { { "nvim-lua/plenary.nvim" } },
    }
    },
    'AlexvZyl/nordic.nvim',
    'catppuccin/nvim',
    {
        'simrat39/symbols-outline.nvim',
        config = function()
            require("symbols-outline").setup()
        end,
    },
    {
        'stevearc/aerial.nvim',
        config = function() require('aerial').setup(
            {
                filter_kind = false,
            })
        end,
    },
    {
        'kevinhwang91/nvim-ufo',
        dependencies = 'kevinhwang91/promise-async',
        config = function()
            require('ufo').setup({
                provider_selector = function(bufnr, filetype, buftype)
                    return {'treesitter', 'indent'}
                end
            })
        end,
    },
    'elvessousa/sobrio',
    'savq/melange-nvim',
    'rebelot/kanagawa.nvim',
    'nvim-pack/nvim-spectre',
    'sainnhe/edge',
    {
        "AckslD/nvim-neoclip.lua",
        config = function()
            require('neoclip').setup({
                keys = {
                    telescope = {
                        i = {
                            select = '<cr>',
                            paste = '<c-p>',
                            paste_behind = '<c-P>',
                            replay = '<c-q>',  -- replay a macro
                            delete = '<c-d>',  -- delete an entry
                            edit = '<c-e>',  -- edit an entry
                            custom = {},
                        },
                        n = {
                            select = '<cr>',
                            paste = 'p',
                            --- It is possible to map to more than one key.
                            -- paste = { 'p', '<c-p>' },
                            paste_behind = 'P',
                            replay = 'q',
                            delete = 'd',
                            edit = 'e',
                            custom = {},
                        },
                    },
                }
            })
                require('telescope').load_extension('neoclip')
            end,
    },
    {
        'rmagatti/goto-preview',
        config = function()
            require('goto-preview').setup()
        end,
    },
    {
        'abecodes/tabout.nvim',
        config = function()
            require('tabout').setup {
                tabkey = '<C-l>', -- key to trigger tabout, set to an empty string to disable
                backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
                act_as_tab = true, -- shift content if tab out is not possible
                act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
                default_tab = '<C-t>', -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
                default_shift_tab = '<C-d>', -- reverse shift default action,
                enable_backwards = true, -- well ...
                completion = true, -- if the tabkey is used in a completion pum
                tabouts = {
                    {open = "'", close = "'"},
                    {open = '"', close = '"'},
                    {open = '`', close = '`'},
                    {open = '(', close = ')'},
                    {open = '[', close = ']'},
                    {open = '{', close = '}'}
                },
                ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
                exclude = {} -- tabout will ignore these filetypes
            }
        end,
        wants = {'nvim-treesitter'}, -- or require if not used so far
        after = {'nvim-cmp'} -- if a completion plugin is using tabs load it before
    },
    'rmehri01/onenord.nvim',
    {
       'folke/twilight.nvim',
       config = function()
           require("twilight").setup()
       end,
   },
   {
       "kylechui/nvim-surround",
       config = function()
           require("nvim-surround").setup({})
       end,
   },
   {
       "folke/trouble.nvim",
       dependencies = "nvim-tree/nvim-web-devicons",
       config = function()
           require("trouble").setup {
           }
       end
   },
   {
       'crispgm/nvim-tabline',
       dependencies = { 'nvim-tree/nvim-web-devicons' }, -- optional
       config = function()
           require('tabline').setup({
               show_index = false,        -- show tab index
               show_modify = true,       -- show buffer modification indicator
               show_icon = false,        -- show file extension icon
               modify_indicator = '[M]', -- modify indicator
               no_name = 'No name',      -- no name buffer name
               brackets = { '', '' },  -- file name brackets surrounding
           })
       end
   },
   {
       'github/copilot.vim',
   },
   {
       dir = '~/projects/nibbler',
       config = function()
           require('nibbler').setup({
               display_enabled = true,
           })
       end,
   },
   {
       'willothy/flatten.nvim',
       config = true
   },
   {
       'folke/twilight.nvim',
       config = true,
   },
   {
       'folke/zen-mode.nvim',
       config = function ()
           require("zen-mode").setup ({
               window = {
                   options = {
                       number = false,
                       relativenumber = false,
                   },
               }
           })
       end
   },
   {
       "iamcco/markdown-preview.nvim",
       build = function() 
           vim.fn["mkdp#util#install"]() 
       end,
   },
   {
       "ellisonleao/glow.nvim",
       cmd = "Glow",
       config = function()
           require("glow").setup({
                style = "dark",
                width = 150,
            })
        end,
    },

    {
        'gbprod/yanky.nvim',
        config = function()
            local mapping = require("yanky.telescope.mapping")
            local actions = require("telescope.actions")
            require("telescope").load_extension("yank_history")
            require('yanky').setup({
                picker = {
                    telescope = {
                        mappings = {
                            i = {
                                ["<c-x>"] = mapping.delete(),
                                ["<C-j>"] = actions.move_selection_next,
                                ["<C-k>"] = actions.move_selection_previous,
                            },
                        }
        }
                }
            })
        end,
    },
    {
        'stevearc/oil.nvim',
        opts = {},
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
} 


