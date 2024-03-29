return {
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
}
