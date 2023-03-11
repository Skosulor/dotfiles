
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

vim.o.foldcolumn = '0'
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.g.everforest_background = 'hard'

-- Key mappings
local n_keymap = function(lhs, rhs)
    vim.api.nvim_set_keymap('n', lhs, rhs, { noremap = true, silent = true })
end

local x_keymap = function(lhs, rhs)
    vim.api.nvim_set_keymap('x', lhs, rhs, { noremap = true, silent = true })
end

vim.cmd([[colorscheme everforest]])
 -- Hide the tildes that denotes end of file
vim.cmd([[highlight! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg]])

-- files
n_keymap('<leader>fn',':e ~/one/one.norg<cr>')
n_keymap('<leader>ft','<cmd>NvimTreeToggle<cr>')
n_keymap('<leader>fs', '<cmd>:lua require"search_files".project_files()<cr>')
n_keymap('<leader>ff', '<cmd>Telescope file_browser<cr>')
n_keymap('<leader>fh', ':lua MiniStarter.open()<cr>')
n_keymap('<leader>ss', '<cmd>:lua require("functions").grep_project()<cr>')

n_keymap('<leader>/', ':lua require("telescope.builtin").current_buffer_fuzzy_find({ sorter = require("telescope.sorters").get_substr_matcher({})})<cr>')
n_keymap('*', '<cmd>Telescope grep_string<cr>')


-- Telescope General
n_keymap('<leader>tp', ':Telescope neoclip<cr>')
n_keymap('<leader>tm', '<cmd>:lua require("functions").man_pages()<cr>')
n_keymap('<leader>ty', '<cmd>Telescope yank_history<cr>')
n_keymap('<leader>td', '<cmd>Telescope diagnostics<cr>')
n_keymap('<leader>tk', '<cmd>Telescope keymaps<cr>')
n_keymap('<leader>th', '<cmd>Telescope help_tags<cr>')
n_keymap('<leader>tn', '<cmd>Telescope notify<cr>')
n_keymap('<leader>to', '<cmd>Telescope oldfiles<cr>')
n_keymap('<leader>;',  '<cmd>Telescope commands<cr>')
n_keymap('<leader><tab><leader>', '<cmd>Telescope buffers<cr>')
n_keymap('<leader>j',             '<cmd>Telescope lsp_document_symbols<cr>')
n_keymap('<leader>J',             '<cmd>Telescope lsp_workspace_symbols<cr>')
n_keymap('gr',                    '<nop>')
n_keymap('gr',                    '<cmd>Telescope lsp_references<cr>')


 -- LSP
n_keymap('gd', ':lua vim.lsp.buf.definition()<cr>')
n_keymap('gl', ':lua vim.diagnostic.open_float()<cr>')
n_keymap('K', ':lua vim.lsp.buf.hover()<enter>')


 -- Git
n_keymap('<leader>gg', '<cmd>vertical Git<cr>')
n_keymap('<leader>gb', '<cmd>Telescope git_branches<cr>')
n_keymap('<leader>gc', '<cmd>Telescope git_commits<cr>')
n_keymap('<leader>gh', '<cmd>GitGutterPreviewHunk<cr>')
n_keymap('<leader>gs', '<cmd>GitGutterStageHunk<cr>')
n_keymap('<leader>gd', '<cmd>GitGutterDiffOrig<cr>')
n_keymap('<leader>gn', '<cmd>GitGutterNextHunk<cr>')
n_keymap('<leader>gp', '<cmd>GitGutterPrevHunk<cr>')
n_keymap('<leader>gm', '<cmd>Git mergetool<cr>')
n_keymap('<leader>gl', '<cmd>GV<cr>')
n_keymap('<leader>gf', '<cmd>Git fetch --all<cr>')
n_keymap('<leader>gu', '<cmd>GitGutterUndoHunk<cr>')
n_keymap('<leader>a',  '<cmd>lua vim.lsp.buf.code_action()<CR>')


 -- Windows
n_keymap('<leader>wv', '<cmd>vsplit<cr><C-W><C-L>')
n_keymap('<leader>ws', '<cmd>split<cr><C-W><C-J>')
n_keymap('<leader>wj', '<C-W><C-J>')
n_keymap('<leader>wk', '<C-W><C-K>')
n_keymap('<leader>wl', '<C-W><C-L>')
n_keymap('<leader>wh', '<C-W><C-H>')
n_keymap('<leader>wo', '<C-W><C-O>')
n_keymap('<leader>wq', ':q!<enter>')

n_keymap('<leader>wJ', '<C-W>J')
n_keymap('<leader>wK', '<C-W>K')
n_keymap('<leader>wL', '<C-W>L')
n_keymap('<leader>wH', '<C-W>H')

-- Harpoon
n_keymap('<leader>hm',        ':lua require("harpoon.mark").add_file()<cr>')
n_keymap('<leader>h<leader>', ':lua require("harpoon.ui").toggle_quick_menu()<cr>')


 -- Code
n_keymap('<leader>cr', '<cmd>Spectre<cr>')
n_keymap('<leader>cs', '<cmd>AerialToggle<cr>')
n_keymap('<leader>ca', ':lua vim.lsp.buf.code_action()<cr>')
n_keymap('<leader>cS', ':lua vim.lsp.buf.document_symbol()<cr>')
n_keymap('<leader>cT', '<cmd>TodoQuickFix<cr>')
n_keymap('<leader>ct', '<cmd>Trouble<cr>')
n_keymap('<leader>cl', '<cmd>Commentary<cr>')
x_keymap('<leader>cl', ':Commentary<cr>')
x_keymap('<leader>ch', ':ClangdSwitchSourceHeader<cr>')
n_keymap('<leader>cP', ':PickColor<cr>')

 -- Terminal
n_keymap('<leader>tt', '<cmd>ToggleTerm<cr>')

-- Tabs
vim.api.nvim_set_keymap('n', '<C-n>', '<CMD>tab new<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<CMD>tabn<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-h>', '<CMD>tabp<cr>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('t', '<C-n>', '<CMD>tab new<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<C-l>', '<CMD>tabn<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<C-h>', '<CMD>tabp<cr>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<C-t>', '<CMD>tab new<cr><CMD>term<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<C-t>', '<CMD>tab new<cr><CMD>term<cr>', { noremap = true, silent = true })

-- vim.api.nvim_set_keymap('n', lhs, rhs, { noremap = true, silent = true })

-- Remove search highlihgt with ESC
vim.api.nvim_set_keymap('n', '<ESC>', ':noh<CR><ESC>', { noremap = true, silent = true })

-- Project
n_keymap('<leader>p', '<cmd>Telescope projects<cr>')

-- Aligning 
vim.api.nvim_set_keymap('n', 'ga', '<Plug>(EasyAlign)', { noremap = false, silent = true })
vim.api.nvim_set_keymap('x', 'ga', '<Plug>(EasyAlign)', { noremap = false, silent = true })


vim.api.nvim_set_keymap('t', '<leader>tt', "<C-\\><C-n><cmd>ToggleTerm<cr>", { noremap = true, silent = true })


-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)



n_keymap('<leader>cp', '<cmd>lua require("goto-preview").goto_preview_definition()<CR>')
vim.api.nvim_set_keymap('n', 'gD', "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", { noremap = true, silent = true })

if vim.g.neovide then
    vim.g.neovide_scroll_animation_length = 0.5
    vim.g.neovide_hide_mouse_when_typing = true

    vim.g.neovide_scale_factor = 1.0

    local change_scale_factor = function(delta)
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    end
    vim.keymap.set("n", "<C-+>", function()
        change_scale_factor(1.25)
    end)
    vim.keymap.set("n", "<C-->", function()
        change_scale_factor(1/1.25)
    end)
end
