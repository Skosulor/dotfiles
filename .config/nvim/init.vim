" TODO's
" * Fix which-key naming
" * Migrate init to lua
" * Keybindings harpoon
" * During autocompletion, jump between arguments with TAB -> its done with
"   C-d (forward) and C-b (backward)
" * Find an alignment plugin
" * https://github.com/aserowy/tmux.nvim    | Tmux and nvim window integration
" * https://github.com/nvim-orgmode/orgmode | Org mode
" * https://github.com/hkupty/iron.nvim     | Integrated repl
" * Add keymaps for tabs

" General 
set relativenumber
set number
set clipboard=unnamedplus
set encoding=UTF-8
set timeoutlen=300

" Indenting
set tabstop=8     
set expandtab    
set shiftwidth=4
set autoindent 
set smartindent
set cindent   
set updatetime=100

" Set File data location
set dir=~/.nvim/swapfiles
set backup
set backupdir=~/.nvim/backupfiles
set undofile
set undodir=~/.nvim/undofiles

" Theme
let g:onedark_config = {
  \ 'style': 'warm',
  \ 'toggle_style_key': '<leader>ts',
  \ 'ending_tildes': v:true,
  \ 'diagnostics': {
    \ 'darker': v:false,
    \ 'background': v:false,
  \ },
\ }


" Keybindings
nnoremap <SPACE> <nop>
let mapleader=" "

" Paste and Yank 
xnoremap("<leader>p", "\"_dP)

" Exit terminal
tnoremap <C-q> <C-\><C-n><C-w><C-w>

" Lsp
nnoremap gd :lua vim.lsp.buf.definition()<enter>
nnoremap gl :lua vim.diagnostic.open_float()<enter>
nnoremap K :lua vim.lsp.buf.hover()<enter>

" File and search
nnoremap <leader>fs <cmd>:lua require"search_files".project_files()<cr>
nnoremap <leader>ff <cmd>Telescope file_browser<cr>
nnoremap <leader>ss <cmd>Telescope live_grep<cr>
nnoremap * <cmd>Telescope grep_string<cr>

" Telescope General
nnoremap <leader><TAB>m <cmd>:lua require'functions'.man_pages()<cr>
nnoremap <leader><TAB>y <cmd>Telescope yank_history<cr>
nnoremap <leader><TAB>d <cmd>Telescope diagnostics<cr>
nnoremap <leader><TAB>k <cmd>Telescope keymaps<cr>
nnoremap <leader><TAB>c <cmd>Telescope commands<cr>
nnoremap <leader><TAB>t <cmd>Telescope treesitter<cr>
nnoremap <leader><TAB>h <cmd>Telescope help_tags<cr>
nnoremap <leader><TAB>p <cmd>:lua require'pydoc_picker'.pydoc()<cr>
nnoremap <leader><TAB>n <cmd>Telescope notify<cr>

" LSP
nnoremap <leader><tab><leader> <cmd>Telescope buffers<cr>
nnoremap <leader>j <cmd>Telescope lsp_document_symbols<cr>
nnoremap <leader>J <cmd>Telescope lsp_workspace_symbols<cr>
nnoremap gr <nop>
nnoremap gr <cmd>Telescope lsp_references<cr>

" Git
nnoremap <leader>gg <cmd>Git<cr>
nnoremap <leader>gb <cmd>Telescope git_branches<cr>
nnoremap <leader>gc <cmd>Telescope git_commits<cr>
nnoremap <leader>gh <cmd>GitGutterPreviewHunk<cr>
nnoremap <leader>gs <cmd>GitGutterStageHunk<cr>
nnoremap <leader>gd <cmd>GitGutterDiffOrig<cr>
nnoremap <leader>gn <cmd>GitGutterNextHunk<cr>
nnoremap <leader>gp <cmd>GitGutterPrevHunk<cr>
nnoremap <leader>gm <cmd>Git mergetool<cr>

" Windows
nnoremap <leader>wv <cmd>vsplit<cr><C-W><C-L>
nnoremap <leader>ws <cmd>split<cr><C-W><C-J>
nnoremap <leader>wj <C-W><C-J>
nnoremap <leader>wk <C-W><C-K>
nnoremap <leader>wl <C-W><C-L>
nnoremap <leader>wh <C-W><C-H>
nnoremap <leader>wo <C-W><C-O>
nnoremap <leader>wq :q!<enter>

" Terminal
nnoremap <leader>tt <cmd>vsplit<cr><C-W><C-L>:term<ENTER>i

" Hop
nnoremap <leader><leader> <cmd>HopWord<cr>

" Clear search-highlight with esc
noremap <ESC> :noh<CR><ESC>

" Aligning
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" SnipRun
xmap <leader>s :SnipRun<cr>

" Plugins
call plug#begin()

" General
Plug 'anuvyklack/windows.nvim'
Plug 'anuvyklack/middleclass'
Plug 'anuvyklack/animation.nvim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'rcarriga/nvim-notify'
Plug 'MunifTanjim/nui.nvim'
Plug 'folke/noice.nvim'
Plug 'michaelb/sniprun', {'do': 'bash install.sh'} 
Plug 'airblade/vim-rooter'
Plug 'karb94/neoscroll.nvim'
Plug 'junegunn/vim-easy-align'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'ggandor/leap.nvim'
Plug 'airblade/vim-gitgutter'
Plug 'jbyuki/venn.nvim'
Plug 'jiangmiao/auto-pairs'
Plug 'nvim-orgmode/orgmode'
Plug 'AckslD/nvim-whichkey-setup.lua'
Plug 'gbprod/yanky.nvim'
Plug 'preservim/nerdcommenter'

" Git
Plug 'sindrets/diffview.nvim'
Plug 'tpope/vim-fugitive'

" Navigation
Plug 'folke/which-key.nvim'
Plug 'phaazon/hop.nvim'
Plug 'ThePrimeagen/harpoon'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'DanilaMihailov/beacon.nvim'
Plug 'rhysd/clever-f.vim'

" Telescope
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-tree/nvim-web-devicons'
Plug 'sharkdp/fd'

" Lsp
Plug 'VonHeikemen/lsp-zero.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'L3MON4D3/LuaSnip', {'tag': 'v<CurrentMajor>.*'}

" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'

" Theming
Plug 'mhinz/vim-startify'
Plug 'nvim-lualine/lualine.nvim'
Plug 'navarasu/onedark.nvim'

call plug#end()

lua <<EOF
-- Transition to lua init
require("init_lua").setup()
EOF

colorscheme onedark

