return {
    'DanilaMihailov/beacon.nvim',
    'chrisbra/NrrwRgn',
    'sainnhe/everforest',
    'rmehri01/onenord.nvim',
    'anuvyklack/animation.nvim',
    'nvim-tree/nvim-web-devicons',
    'AlexvZyl/nordic.nvim',
    'catppuccin/nvim',
    'rebelot/kanagawa.nvim',
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
        'navarasu/onedark.nvim',
        config = function()
            require('onedark').setup {
                style = 'dark'
            }
            vim.cmd([[colorscheme onedark]])
        end,
    },
    {
        'simrat39/symbols-outline.nvim',
        config = function()
            require("symbols-outline").setup()
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
        'folke/noice.nvim',
        config = function()
            require("noice").setup({
                excluded_filetypes = { "cmp_menu", "cmp_docs", "notify" },
                views = {
                    confirm = {
                        enabled = false,
                    },
                    messages = {

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
                            width = 130,
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

        end,
    },
}
