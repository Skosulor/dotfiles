return {
    { "folke/neoconf.nvim", cmd = "Neoconf" },
    'nvim-telescope/telescope-file-browser.nvim',
    'junegunn/fzf.vim',
    'tommcdo/vim-lion',
    'tpope/vim-fugitive',
    'pechorin/any-jump.vim',
    'junegunn/gv.vim',
    'airblade/vim-gitgutter',
    'nvim-neotest/nvim-nio',
    'ludovicchabant/vim-gutentags',
    -- 'https://github.com/github/copilot.vim',
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
    'luisiacc/gruvbox-baby',
    'projekt0n/caret.nvim',
    'junegunn/seoul256.vim',
    'DanilaMihailov/beacon.nvim',
    'sainnhe/gruvbox-material',
    'chrisbra/NrrwRgn',
    'sainnhe/everforest',
    'anuvyklack/animation.nvim',
    'nvim-tree/nvim-web-devicons',
    'AlexvZyl/nordic.nvim',
    'catppuccin/nvim',
    'rebelot/kanagawa.nvim',
    -- '/Th3Whit3Wolf/one-nvim',
    'RRethy/nvim-base16',
    'NTBBloodbath/doom-one.nvim',
    'drewtempelmeyer/palenight.vim',
    'rmehri01/onenord.nvim',
    'romgrk/doom-one.vim',
    {
      "ibhagwan/fzf-lua",
      -- optional for icon support
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
        -- calling `setup` is optional for customization
        require("fzf-lua").setup({})
      end
    },
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
        'nvim-telescope/telescope-fzf-native.nvim', 
        build = 'make',
        config = function ()
            require('telescope').load_extension('fzf')
        end,
    },
    {
        'folke/todo-comments.nvim',
        config = function()
            require("todo-comments").setup()
        end,
    },
    -- {
    --     'anuvyklack/windows.nvim',
    --     config = function()
    --         require('windows').setup({
    --             autowidth = {
    --                 enable = true,
    --                 winwidth = 10,
    --             },
    --             ignore = {
    --                 buftype = { "quickfix", "Telescope", "telescope"},
    --                 filetype = { "NvimTree", "neo-tree", "undotree", "gundo", "Telescope", "telescope", }
    --             },
    --
    --             animation = {
    --                 enable = false,
    --                 duration = 300,
    --                 fps = 60,
    --                 easing = "in_out_sine"
    --             }
    --         })
    --     end,
    -- },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {
            search = {
                enabled = false,
            }
        },
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
    },
    {
        'navarasu/onedark.nvim',
        config = function()
            require('onedark').setup {
                style = 'warm'
            }
            vim.cmd([[colorscheme onedark]])
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
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                        keymaps = {
                            -- You can define your own textobjects here:
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["av"] = "@parameter.outer",
                            ["iv"] = "@parameter.inner",
                        },
                    },
                },
            }
        end,
    },
    {
        'rose-pine/neovim',
        name = 'rose-pine'
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
        'folke/twilight.nvim',
        config = function()
            require("twilight").setup()
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        config = function ()
            require('lualine').setup(
            {
                options = {
                    theme = 'auto',
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    globalstatus = true,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                    }
                }
            }
            )
        end,
    },
    {
        'simrat39/symbols-outline.nvim',
        config = function()
            require("symbols-outline").setup()
        end,
    }, 
    {
        'folke/noice.nvim',
        config = function()
            require("noice").setup({
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                },
                -- you can enable a preset for easier configuration
                views = {
                    confirm = {
                        enabled = false,
                    },
                    cmdline_popup = {
                        position = {
                            row = 20,
                            col = "50%",
                        },
                        size = {
                            width = 130,
                            height = "auto",
                        },
                    },
                },
                presets = {
                    bottom_search = false, -- use a classic bottom cmdline for search
                    command_palette = true, -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false, -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false, -- add a border to hover docs and signature help
                },
                messages = {
                    enabled = true, -- enables the Noice messages UI
                },
                notify = {
                    enabled = false,
                }
            })
        end,
    },
    {
        -- Using vscode extension for gdb
        -- Download: https://github.com/microsoft/vscode-cpptools/releases
        -- Unpack it. .vsix is a zip file and you can use unzip to extract the contents.
        -- Ensure extension/debugAdapters/bin/OpenDebugAD7 is executable.
        'mfussenegger/nvim-dap',
        config = function()
            local dap = require('dap')

            -- dap.adapters.lldb = {
            --     type = 'server',
            --     port = "1234",
            --     executable = {
            --         command = '/opt/homebrew/opt/llvm/bin/lldb-vscode',
            --         args = {"--port", "1234"},
            --     }
            -- }

            dap.adapters.codelldb = {
                type = 'server',
                port = "1234",
                executable = {
                    command = '/home/strom/.vscode-oss/extensions/vadimcn.vscode-lldb-1.10.0-universal/adapter/codelldb',
                    args = {"--port", "1234"},
                }
            }


            dap.configurations.rust = {
                {
                    name = "Launch",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}',
                    stopOnEntry = false,
                    args = {},
                },
            }

            dap.configurations.c = {
                {
                    name = "Launch file",
                    type = "lldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}',
                    stopOnEntry = false,
                },
            }
        end
    },
    {
        "rcarriga/nvim-dap-ui",
        config = function()
            require "dapui".setup()
            local dap = require('dap')
            local dapui = require('dapui')
            dap.listeners.after.event_initialized["dapui_config"]=function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"]=function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"]=function()
                dapui.close()
            end
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        lazy = false,
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
                    vimgrep_arguments = {
                        "rg",
                        "-L",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                    },
                    prompt_prefix = "   ",
                    selection_caret = "  ",
                    entry_prefix = "  ",
                    initial_mode = "insert",
                    selection_strategy = "reset",
                    sorting_strategy = "descending",
                    layout_config = {
                        horizontal = {
                            preview_width = 0.55,
                            results_width = 0.8,
                        },
                        vertical = {
                            mirror = false,
                        },
                        width = 0.87,
                        height = 0.80,
                        preview_cutoff = 20,
                    },
                    file_sorter = require("telescope.sorters").get_fuzzy_file,
                    file_ignore_patterns = { "node_modules" },
                    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
                    path_display = { "truncate" },
                    winblend = 0,
                    border = true,
                    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
                    color_devicons = true,
                    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
                    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
                    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
                    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
                    -- Developer configurations: Not meant for general override
                    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
                    mappings = {
                        n = { ["q"] = require("telescope.actions").close },
                        i = {
                            ["<C-i>"] = fb_actions.toggle_hidden,
                            ["<C-h>"] = fb_actions.goto_parent_dir,
                            ['<c-d>'] = actions.delete_buffer,
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<C-l>"] = actions.select_default,
                        },
                    },

                    layout_strategy = "horizontal",
                },
            })
            require("telescope").load_extension "file_browser"
        end,
    },
    {
        'nvim-tree/nvim-tree.lua',
        config = function()
            require("nvim-tree").setup()
        end,
    },
    {
        'ahmedkhalf/project.nvim',
        config = function()
            require('telescope').load_extension('projects')
            require("project_nvim").setup ({
                patterns = {'.vproject'},
                sync_root_with_cwd = true,
                respect_buf_cwd = true,
                detection_methods = { "pattern", "lsp" },
                show_hidden = true,
                silent_chdir = false,
                scope_chdir = 'win',
                update_focused_file = {
                    enable = true,
                    update_root = true
                },
            })
        end,

    },
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
        'stevearc/oil.nvim',
        opts = {},
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
        },
        keys = {
            { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
        requires = "nvim-treesitter/nvim-treesitter",
    },
    {
        'nvim-orgmode/orgmode',
        event = 'VeryLazy',
        ft = { 'org' },
        config = function()
            require('orgmode').setup({
                org_agenda_files = '~/orgfiles/**/*',
                org_default_notes_file = '~/orgfiles/refile.org',
            })
        end,
    },
    {
        "chipsenkbeil/org-roam.nvim",
        -- tag = "0.1.0",
        dependencies = {
            {
                "nvim-orgmode/orgmode",
                -- tag = "0.3.4",
            },
        },
        config = function()
            require("org-roam").setup({
                directory = "~/org/roam",
            })
        end
    }
}
