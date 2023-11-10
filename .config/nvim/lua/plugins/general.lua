return {
    { "folke/neoconf.nvim", cmd = "Neoconf" },
    'nvim-pack/nvim-spectre',
    'nvim-treesitter/nvim-treesitter-context',
    'rhysd/clever-f.vim',
    'nvim-lua/plenary.nvim',
    'sharkdp/fd',
    'junegunn/vim-easy-align',
    'MunifTanjim/nui.nvim',
    'anuvyklack/middleclass',
    'kevinhwang91/nvim-bqf',
    'tpope/vim-commentary',
    'sindrets/diffview.nvim',
    {
        'windwp/nvim-autopairs',
        config = function()
            require("nvim-autopairs").setup({})
        end
    },
    {
        "epwalsh/obsidian.nvim",
        -- lazy = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()

                local vault = ''
                if package.config:sub(1,1) == '/' then
                    vault = "/Users/ohman/Documents/ObsidianVault"
                elseif package.config:sub(1,1) == "\\" then
                    vault = "C:\\Users\\AndreasOhman\\Documents\\Notes"
                end

            require("obsidian").setup({
                dir = "/Users/ohman/Documents/ObsidianVault",
            })
        end,
    },
    {
        "folke/neodev.nvim",
        config = function()
            require("neodev").setup({})
        end,
    },
    {
        'ziontee113/color-picker.nvim',
        config = function()
            local colorpicker = require('color-picker')
            colorpicker.setup()
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
    {
        'folke/todo-comments.nvim',
        config = function()
            require("todo-comments").setup()
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
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {},
        keys = {
            {
                "s",
                mode = { "n", "x", "o" },
                function()
                    require("flash").jump()
                end,
                desc = "Flash",
            },
            {
                "S",
                mode = { "n", "o", "x" },
                function()
                    require("flash").treesitter()
                end,
                desc = "Flash Treesitter",
            },
            {
                "r",
                mode = "o",
                function()
                    require("flash").remote()
                end,
                desc = "Remote Flash",
            },
            {
                "R",
                mode = { "o", "x" },
                function()
                    require("flash").treesitter_search()
                end,
                desc = "Flash Treesitter Search",
            },
            {
                "<c-s>",
                mode = { "c" },
                function()
                    require("flash").toggle()
                end,
                desc = "Toggle Flash Search",
            },
        },
    },
    {
        'folke/which-key.nvim',
        config = function ()
            require("which-key").setup {}
        end,
    },
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
       'skosulor/nibbler',
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
       "sourcegraph/sg.nvim",
       dependencies = { "nvim-lua/plenary.nvim", --[[ "nvim-telescope/telescope.nvim ]] },

       -- If you have a recent version of lazy.nvim, you don't need to add this!
       build = "nvim -l build/init.lua",
   },
}
