return {
    'nvim-telescope/telescope-file-browser.nvim',
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
        'nvim-telescope/telescope-fzf-native.nvim', 
        build = 'make',
        config = function ()
            require('telescope').load_extension('fzf')
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
}

