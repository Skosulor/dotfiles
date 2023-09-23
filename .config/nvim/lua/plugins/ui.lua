return {
    'sainnhe/everforest',
    'rmehri01/onenord.nvim',
    'anuvyklack/animation.nvim',
    'nvim-tree/nvim-web-devicons',
    'AlexvZyl/nordic.nvim',
    'catppuccin/nvim',
    'rebelot/kanagawa.nvim',
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
