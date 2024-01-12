return {
    { "folke/neoconf.nvim", cmd = "Neoconf" },
    'ludovicchabant/vim-gutentags',
    'https://github.com/github/copilot.vim',
    'nvim-pack/nvim-spectre',
    'nvim-treesitter/nvim-treesitter-context',
    'rhysd/clever-f.vim',
    'nvim-lua/plenary.nvim',
    'sharkdp/fd',
    'junegunn/vim-easy-align',
    'MunifTanjim/nui.nvim',
    'anuvyklack/middleclass',
    'kevinhwang91/nvim-bqf',
    'sindrets/diffview.nvim',
    {
        'windwp/nvim-autopairs',
        config = function()
            require("nvim-autopairs").setup({})
        end
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
       -- "sourcegraph/sg.nvim",
       -- dependencies = { "nvim-lua/plenary.nvim", --[[ "nvim-telescope/telescope.nvim ]] },
       --
       -- -- If you have a recent version of lazy.nvim, you don't need to add this!
       -- build = "nvim -l build/init.lua",
   },
   {
       'echasnovski/mini.nvim',
       version = '*',
       config = function()
           require('mini.bufremove').setup({})
           local header_art = 
           [[
           ╭╮╭╮╭╮╱╱╭╮
           ┃┃┃┃┃┃╱╱┃┃
           ┃┃┃┃┃┣━━┫┃╭━━┳━━┳╮╭┳━━╮
           ┃╰╯╰╯┃┃━┫┃┃╭━┫╭╮┃╰╯┃┃━┫
           ╰╮╭╮╭┫┃━┫╰┫╰━┫╰╯┃┃┃┃┃━┫
           ╱╰╯╰╯╰━━┻━┻━━┻━━┻┻┻┻━━╯
           ]]
           local starter = require'mini.starter'
           starter.setup {
               items = {
                   starter.sections.telescope(),
                   {name = "Daily Notes", action = "ObsidianToday", section = "Doc's"},
                   {name = "Yesterday's Notes", action = "ObsidianYesterday", section = "Doc's"},
                   {name = "Plugins", action = ":Oil ~/.config/nvim/lua/plugins", section = "Doc's"},
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
	   'numToStr/Comment.nvim',
	   opts = {},
	   lazy = false,
   },
   {
	   "NeogitOrg/neogit",
	   dependencies = {
		   "nvim-lua/plenary.nvim",
		   "sindrets/diffview.nvim",
		   "nvim-telescope/telescope.nvim",
		   "ibhagwan/fzf-lua",
	   },
	   config = true
   },
   {
   'Vigemus/iron.nvim',
       config = function()
           local iron = require("iron.core")
           local view = require("iron.view")
           iron.setup {
               config = {
                   scratch_repl = true,
                   repl_definition = {
                       sh = {
                           command = {"cmd"}
                       }
                   },
                   repl_open_cmd = view.right("20%")
               },
               highlight = {
                   italic = true
               },
               ignore_blank_lines = true,
           }
       end
   },
   {
       'ludovicchabant/vim-gutentags',
       config = function()
           -- https://www.reddit.com/r/vim/comments/d77t6j/guide_how_to_setup_ctags_with_gutentags_properly/
           vim.g.gutentags_ctags_exclude = {
               '*.git',
               '*.svg',
               '*.hg',
               '*/tests/*',
               'build',
               'dist',
               '*sites/*/files/*',
               'bin',
               'node_modules',
               'bower_components',
               'cache',
               'compiled',
               'docs',
               'example',
               'bundle',
               'vendor',
               '*.md',
               '*-lock.json',
               '*.lock',
               '*bundle*.js',
               '*build*.js',
               '.*rc*',
               '*.json',
               '*.min.*',
               '*.map',
               '*.bak',
               '*.zip',
               '*.pyc',
               '*.class',
               '*.sln',
               '*.Master',
               '*.csproj',
               '*.tmp',
               '*.csproj.user',
               '*.cache',
               '*.pdb',
               'tags*',
               'cscope.*',
               -- '*.css',
               -- '*.less',
               -- '*.scss',
               '*.exe',
               '*.dll',
               '*.mp3',
               '*.ogg',
               '*.flac',
               '*.swp',
               '*.swo',
               '*.bmp',
               '*.gif',
               '*.ico',
               '*.jpg',
               '*.png',
               '*.rar',
               '*.zip',
               '*.tar',
               '*.tar.gz',
               '*.tar.xz',
               '*.tar.bz2',
               '*.pdf',
               '*.doc',
               '*.docx',
               '*.ppt',
               '*.pptx',
           }

           vim.g.gutentags_add_default_project_roots = false
           vim.g.gutentags_project_root = { '.vproject' }
           -- vim.g.gutentags_cache_dir = vim.fn.stdpath("data") .. '\\ctags'
           vim.g.gutentags_generate_on_new = true
           vim.g.gutentags_generate_on_missing = true
           vim.g.gutentags_generate_on_write = true
           vim.g.gutentags_generate_on_empty_buffer = true
           vim.g.gutentags_modules = true
           -- vim.cmd([[command! -nargs=0 GutentagsClearCache call system('rm ' . g:gutentags_cache_dir . '/*')]])
           vim.g.gutentags_ctags_extra_args = { '--tag-relative=yes', '--fields=+ailmnS', }


           -- custom
           vim.g.gutentags_modules = { 'ctags' }
       end
   }
}
