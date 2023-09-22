local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "
require("lazy").setup("plugins", opts)
require("mappings")

local set = vim.opt

set.relativenumber = true
set.number         = true
set.clipboard      = "unnamedplus"
set.encoding       = "UTF-8"
set.timeoutlen     = 300

set.tabstop     = 8
set.expandtab   = true
set.shiftwidth  = 4
set.autoindent  = true
set.ignorecase  = true
set.smartindent = true
set.cindent     = true
set.updatetime  = 100

set.dir = vim.fn.stdpath('config') .. "/undo"
set.backup = true
set.backupdir = vim.fn.stdpath('config') .. '/backupfiles'
set.undofile = true

vim.o.nowrap = true
vim.o.foldcolumn = '0'
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.g.everforest_background = 'soft'
set.background = 'light'

toggleDarkMode = function()
    if vim.opt.background:get() == 'dark' then
        vim.opt.background = 'light'
    else
        vim.opt.background = 'dark'
    end
end

local keymap = function(mode, lhs, rhs, opts)
    opts = opts or { noremap = true, silent = true }
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

set.grepprg = "rg --vimgrep --no-heading --smart-case"

vim.cmd([[colorscheme everforest]])
 -- Hide the tildes that denotes end of file
vim.cmd([[highlight! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg]])


-- Non leader key bindings
keymap('n', 'gr',                    '<nop>')
keymap('n', 'gr',                    '<cmd>Telescope lsp_references<cr>')
keymap('x', '<leader>cl', ':Commentary<cr>')
keymap('x', '<leader>ch', ':ClangdSwitchSourceHeader<cr>')


-- Tabs
keymap('n', '<C-n>', '<CMD>tab new<cr><CMD>lua MiniStarter.open()<cr>', { noremap = true, silent = true })
keymap('n', '<C-l>', '<CMD>tabn<cr>', { noremap = true, silent = true })
keymap('n', '<C-h>', '<CMD>tabp<cr>', { noremap = true, silent = true })

keymap('t', '<C-n>', '<CMD>tab new<cr>', { noremap = true, silent = true })
keymap('t', '<C-l>', '<CMD>tabn<cr>', { noremap = true, silent = true })
keymap('t', '<C-h>', '<CMD>tabp<cr>', { noremap = true, silent = true })

keymap('n', '<C-t>', '<CMD>tab new<cr><CMD>term<cr>', { noremap = true, silent = true })
keymap('t', '<C-t>', '<CMD>tab new<cr><CMD>term<cr>', { noremap = true, silent = true })


 -- LSP
keymap('n', 'gd', ':lua vim.lsp.buf.definition()<cr>')
keymap('n', 'gl', ':lua vim.diagnostic.open_float()<cr>')
keymap('n', 'K', ':lua vim.lsp.buf.hover()<enter>')

 -- Windows

-- Harpoon
keymap('n', '<leader>hm',        ':lua require("harpoon.mark").add_file()<cr>')
keymap('n', '<leader>h<leader>', ':lua require("harpoon.ui").toggle_quick_menu()<cr>')

 -- Terminal
keymap('n', '<leader><tab>', '<cmd>ToggleTerm<cr>')
keymap('t', '<leader><tab>', "<C-\\><C-n><cmd>ToggleTerm<cr>", { noremap = true, silent = true })

-- Remove search highlihgt with ESC
keymap('n', '<ESC>', ':noh<CR><ESC>', { noremap = true, silent = true })

-- Aligning 
keymap('n', 'ga', '<Plug>(EasyAlign)', { noremap = false, silent = true })
keymap('x', 'ga', '<Plug>(EasyAlign)', { noremap = false, silent = true })

-- Zen mode 

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)


vim.g.copilot_no_tab_map = true
-- Uncomment to enable copilot autocompletion
keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

-- Nibbler
keymap('n', '<C-b>', '<cmd>NibblerToggle<cr>')
keymap('v', '<C-b>', '<cmd>NibblerToggle<cr>')
keymap('n', '<C-g>', '<cmd>NibblerToBin<cr>')
keymap('v', '<C-g>', '<cmd>NibblerToBin<cr>')

-- Goto 
keymap('n', 'gD', "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", { noremap = true, silent = true })

keymap('n', '<C-e>', '<C-e>j')
keymap('n', '<C-y>', '<C-y>k')

-- Fix for Cmp missing lsp completion
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

local neogit = require('neogit')
neogit.setup {}


cmp.setup({
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'buffer', keyword_length = 3},
    {name = 'luasnip', keyword_length = 2},
  },
})

if vim.g.neovide then
    vim.g.neovide_scroll_animation_length = 0.5
    vim.g.neovide_hide_mouse_when_typing = true

    vim.g.neovide_scale_factor = 1.0

    local change_scale_factor = function(delta)
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    end
    vim.keymap.set("n", "<C-+>", function()
        change_scale_factor(1.10)
    end)
    vim.keymap.set("n", "<C-->", function()
        change_scale_factor(1/1.10)
    end)
    vim.o.guifont = "Iosevka"
end


