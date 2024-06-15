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

vim.cmd([[autocmd! BufEnter * if &ft ==# 'help' | wincmd L | endif]])


local set = vim.opt
set.conceallevel = 2
set.concealcursor = 'nc'

set.relativenumber = true
set.number         = true
set.clipboard      = "unnamedplus"
set.encoding       = "UTF-8"
set.timeoutlen     = 300

set.termguicolors = true
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

vim.o.wrap = false
vim.o.foldcolumn = '0'
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.g.everforest_background = 'soft'
set.background = 'dark'
set.grepprg = "rg --vimgrep --no-heading --smart-case"

toggleDarkMode = function()
    if vim.opt.background:get() == 'dark' then
        vim.opt.background = 'light'
    else
        vim.opt.background = 'dark'
    end
end

vim.cmd([[colorscheme everforest]])
 -- Hide the tildes that denotes end of file
vim.cmd([[highlight! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg]])

-- Transparent 
vim.cmd([[highlight Normal guibg=none]])


if vim.g.neovide then
    vim.g.neovide_scroll_animation_length = 0.5
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_scale_factor = 1.0

    local change_scale_factor = function(delta)
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    end

    vim.keymap.set("n", "<C-+>", 
    function()
        change_scale_factor(1.10)
    end)

    vim.keymap.set("n", "<C-->", 
    function()
        change_scale_factor(1/1.10)
    end)
    change_scale_factor(1/1.10)
    vim.o.guifont = "Iosevka"
end

-- Lsp

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

-- to learn how to use mason.nvim
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {},
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
      require('lspconfig').clangd.setup({
          capabilities = {
              offsetEncoding = 'utf-8',
          },
      })   
    end,
  },
})

