
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

vim.g.everforest_background = 'soft'

local keymap = function(mode, lhs, rhs, opts)
    opts = opts or { noremap = true, silent = true }
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

vim.cmd([[colorscheme everforest]])
 -- Hide the tildes that denotes end of file
vim.cmd([[highlight! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg]])

-- files
keymap('n', '<leader>fn',':e ~/one/one.norg<cr>')
keymap('n', '<leader>ft','<cmd>NvimTreeToggle<cr>')
keymap('n', '<leader>fs', '<cmd>:lua require"search_files".project_files()<cr>')
keymap('n', '<leader>ff', '<cmd>Telescope file_browser<cr>')
keymap('n', '<leader>fh', ':lua MiniStarter.open()<cr>')
keymap('n', '<leader>fw', '<cmd>write<cr>')
keymap('n', '<leader>ss', '<cmd>:lua require("functions").grep_project()<cr>')
keymap('n', '<leader>fr', '<cmd>Telescope oldfiles<cr>')

keymap('n', '<leader>/', ':lua require("telescope.builtin").current_buffer_fuzzy_find({ sorter = require("telescope.sorters").get_substr_matcher({})})<cr>')
keymap('n', '*', '<cmd>Telescope grep_string<cr>')


-- Telescope General
keymap('n', '<leader>tp', ':Telescope neoclip<cr>')
keymap('n', '<leader>tm', '<cmd>:lua require("functions").man_pages()<cr>')
keymap('n', '<leader>ty', '<cmd>Telescope yank_history<cr>')
keymap('n', '<leader>td', '<cmd>Telescope diagnostics<cr>')
keymap('n', '<leader>tk', '<cmd>Telescope keymaps<cr>')
keymap('n', '<leader>th', '<cmd>Telescope help_tags<cr>')
keymap('n', '<leader>tn', '<cmd>Telescope notify<cr>')
keymap('n', '<leader>;',  '<cmd>Telescope commands<cr>')
keymap('n', '<leader>tb', '<cmd>Telescope buffers<cr>')
keymap('n', '<leader>j',             '<cmd>Telescope lsp_document_symbols<cr>')
keymap('n', '<leader>J',             '<cmd>Telescope lsp_workspace_symbols<cr>')
keymap('n', 'gr',                    '<nop>')
keymap('n', 'gr',                    '<cmd>Telescope lsp_references<cr>')


 -- LSP
keymap('n', 'gd', ':lua vim.lsp.buf.definition()<cr>')
keymap('n', 'gl', ':lua vim.diagnostic.open_float()<cr>')
keymap('n', 'K', ':lua vim.lsp.buf.hover()<enter>')


 -- Git
keymap('n', '<leader>gg', '<cmd>vertical Git<cr>')
keymap('n', '<leader>gb', '<cmd>Telescope git_branches<cr>')
keymap('n', '<leader>gc', '<cmd>Telescope git_commits<cr>')
keymap('n', '<leader>gh', '<cmd>GitGutterPreviewHunk<cr>')
keymap('n', '<leader>gs', '<cmd>GitGutterStageHunk<cr>')
keymap('n', '<leader>gd', '<cmd>GitGutterDiffOrig<cr>')
keymap('n', '<leader>gn', '<cmd>GitGutterNextHunk<cr>')
keymap('n', '<leader>gp', '<cmd>GitGutterPrevHunk<cr>')
keymap('n', '<leader>gm', '<cmd>Git mergetool<cr>')
keymap('n', '<leader>gl', '<cmd>GV<cr>')
keymap('n', '<leader>gf', '<cmd>Git fetch --all<cr>')
keymap('n', '<leader>gu', '<cmd>GitGutterUndoHunk<cr>')
keymap('n', '<leader>a',  '<cmd>lua vim.lsp.buf.code_action()<CR>')


 -- Windows
keymap('n', '<leader>w', '<C-W>')

-- Harpoon
keymap('n', '<leader>hm',        ':lua require("harpoon.mark").add_file()<cr>')
keymap('n', '<leader>h<leader>', ':lua require("harpoon.ui").toggle_quick_menu()<cr>')


 -- Code
keymap('n', '<leader>cr', '<cmd>Spectre<cr>')
keymap('n', '<leader>cs', '<cmd>AerialToggle<cr>')
keymap('n', '<leader>ca', ':lua vim.lsp.buf.code_action()<cr>')
keymap('n', '<leader>cS', ':lua vim.lsp.buf.document_symbol()<cr>')
keymap('n', '<leader>cT', '<cmd>TodoQuickFix<cr>')
keymap('n', '<leader>ct', '<cmd>Trouble<cr>')
keymap('n', '<leader>cl', '<cmd>Commentary<cr>')
keymap('x', '<leader>cl', ':Commentary<cr>')
keymap('x', '<leader>ch', ':ClangdSwitchSourceHeader<cr>')
keymap('n', '<leader>cP', ':PickColor<cr>')

 -- Terminal
keymap('n', '<leader><tab>', '<cmd>ToggleTerm<cr>')
keymap('t', '<leader><tab>', "<C-\\><C-n><cmd>ToggleTerm<cr>", { noremap = true, silent = true })


-- Tabs
keymap('n', '<C-n>', '<CMD>tab new<cr><CMD>lua MiniStarter.open()<cr>', { noremap = true, silent = true })
keymap('n', '<C-l>', '<CMD>tabn<cr>', { noremap = true, silent = true })
keymap('n', '<C-h>', '<CMD>tabp<cr>', { noremap = true, silent = true })

keymap('t', '<C-n>', '<CMD>tab new<cr>', { noremap = true, silent = true })
keymap('t', '<C-l>', '<CMD>tabn<cr>', { noremap = true, silent = true })
keymap('t', '<C-h>', '<CMD>tabp<cr>', { noremap = true, silent = true })

keymap('n', '<C-t>', '<CMD>tab new<cr><CMD>term<cr>', { noremap = true, silent = true })
keymap('t', '<C-t>', '<CMD>tab new<cr><CMD>term<cr>', { noremap = true, silent = true })

-- vim.api.nvim_set_keymap('n', lhs, rhs, { noremap = true, silent = true })

-- Remove search highlihgt with ESC
keymap('n', '<ESC>', ':noh<CR><ESC>', { noremap = true, silent = true })

-- Project
keymap('n', '<leader>p', '<cmd>Telescope projects<cr>')

-- Aligning 
keymap('n', 'ga', '<Plug>(EasyAlign)', { noremap = false, silent = true })
keymap('x', 'ga', '<Plug>(EasyAlign)', { noremap = false, silent = true })

-- Zen mode 
keymap('n', '<leader>z', '<cmd>ZenMode<cr>', { noremap = false, silent = true })

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)


vim.g.copilot_no_tab_map = true
keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

-- Nibbler
keymap('n', '<C-b>', '<cmd>NibblerToggle<cr>')
keymap('v', '<C-b>', '<cmd>NibblerToggle<cr>')
keymap('n', '<C-g>', '<cmd>NibblerToBin<cr>')
keymap('v', '<C-g>', '<cmd>NibblerToBin<cr>')

-- Yank history
keymap('n', '<leader>y', '<cmd>Telescope yank_history<cr>')

-- Goto 
keymap('n', '<leader>cp', '<cmd>lua require("goto-preview").goto_preview_definition()<CR>')
keymap('n', 'gD', "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", { noremap = true, silent = true })


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


