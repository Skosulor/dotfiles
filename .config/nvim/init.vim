" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  set undofile		" keep an undo file (undo changes after closing)
endif
set history=100		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching


" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
filetype on

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif

set number
" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.

syntax enable
filetype on

" ====== GRAPHICAL SETTINGS ======
colorscheme peachpuff
set tabstop=4 softtabstop=0 expandtab shiftwidth=2 smarttab
hi MatchParen cterm=none ctermbg=white ctermfg=black
hi Visual  guifg=#000000 guibg=#000000 gui=none
hi Visual term=NONE cterm=NONE guibg=NONE
highlight Visual cterm=NONE ctermbg=0 ctermfg=NONE guibg=Grey40
"colo seoul256
"hi Normal guibg=NONE ctermbg=NONE
"hi LineNr ctermbg=NONE
" ======        END         ======

" ====== DIR FOR BACKUPS AND SWP ======

set backupdir=/home/ohman/.vimBackup,.
set directory=/home/ohman/.vimBackup,.

" ======          END            ======

" ====== PLUGINS ======
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'junegunn/seoul256.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'marcweber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'vim-scripts/AutoClose'
Plug 'easymotion/vim-easymotion' "Default bindings Lnope
Plug 'shougo/deoplete.nvim'
Plug 'dbeniamine/cheat.sh-vim'
Plug 'roxma/nvim-yarp'
Plug 'itchyny/lightline.vim'
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'majutsushi/tagbar'
Plug 'jsfaint/gen_tags.vim'
Plug 'tpope/vim-fugitive'
Plug 'lervag/vimtex'
Plug 'mhinz/neovim-remote'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'haya14busa/vim-easyoperator-line'
Plug 'rhysd/clever-f.vim'
" Plug 'donRaphaco/neotex', { 'for': 'tex' }
call plug#end()                
" ====== PLUGINS ======

" ===== deoplte =======
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete
call deoplete#custom#option('max_list', 10)

" === Gen_Tags settings" === "

let g:gen_tags#gtags_default_map = 0
let g:gen_tags#verbose = 0

" === Gen_Tags END" === "

"--- Goyo settings ---"
 let g:goyo_width=90
 let g:goyo_height=200

 autocmd! User GoyoLeave
 autocmd User GoyoLeave nested highlight Normal ctermbg=NONE guibg=NONE
 
 "--- Limelight settings ---"
 let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

" Default: 0.5
let g:limelight_default_coefficient = 0.7

" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 1

" Beginning/end of paragraph
"   When there's no empty line between the paragraphs
"   and each paragraph starts with indentation
let g:limelight_bop = '^\s'
let g:limelight_eop = '\ze\n^\s'

" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1

 "--------"
 

let g:lightline = {
  \ 'colorscheme': 'jellybeans',
  \ }

let g:hardtime_default_on = 1


" ====== MY MAPPINGS ======
let mapleader="\<Space>" 
let maplocalleader="++"
imap <C-c> NOPE
imap <C-k> {
imap <C-l> }
imap <C-e> [
imap <C-r> ]

"Find functions calling this function
"nmap <Leader>q :cs find c <C-R>=expand('<cword>')<CR><CR>
"
"Find functions called by this function
"map <Leader>2 :cs find d <C-R>=expand('<cword>')<CR><CR>
"
"Find this egrep pattern
"nmap <Leader>3 :cs find e <C-R>=expand('<cword>')<CR><CR>
"
"Find this file
"nmap <Leader>4 :cs find f <C-R>=expand('<cfile>')<CR><CR>

"Find this definition
nmap <Leader>d :cs find g <C-R>=expand('<cword>')<CR><CR>

"Find files #including this file
"nmap <Leader>6 :cs find i <C-R>=expand('<cfile>')<CR><CR>

"Find this C symbol
"nmap <Leader>7 :cs find s <C-R>=expand('<cword>')<CR><CR>

"Find this text string
"nmap <Leader>8 :cs find t <C-R>=expand('<cword>')<CR><CR>



set relativenumber

hi VertSplit cterm=None gui=None
" highlight LineNr ctermfg=darkGrey
" highlight Comment ctermfg=darkGrey




let g:gruvbox_contrast_dark='dark'
colorscheme gruvbox
let g:gruvbox_contrast_dark='dark'
set bg=dark
highlight Normal ctermbg=NONE guibg=NONE

set clipboard=unnamedplus

" let g:tagbar_iconchars = ['+','-']

" ===== vimtex ===== "
"my settings"
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_complete_enabled = 1
let g:vimtex_complete_close_braces = 1
let g:vimtex_view_method = 'zathura'


""other dudes settings"
"let g:tex_stylish = 1
"let g:tex_conceal = ''
"let g:tex_flavor = 'latex'
"let g:tex_isk='48-57,a-z,A-Z,192-255,:'
"let g:vimtex_fold_enabled = 0
"let g:vimtex_fold_types = {
"      \ 'sections' : {'parse_levels': 1},
"      \}
"let g:vimtex_format_enabled = 1
"let g:vimtex_view_automatic = 1
"" let g:vimtex_view_forward_search_on_start = 0
"let g:vimtex_toc_config = {
"      \ 'split_pos' : 'full',
"      \ 'mode' : 2,
"      \ 'fold_enable' : 1,
"      \ 'hotkeys_enabled' : 1,
"      \ 'hotkeys_leader' : '',
"      \ 'refresh_always' : 1,
"      \}
"let g:vimtex_quickfix_open_on_warning = 1
"let g:vimtex_quickfix_autoclose_after_keystrokes = 3
"let g:vimtex_imaps_leader = '\|'
"let g:vimtex_complete_img_use_tail = 1
"let g:vimtex_complete_bib = {
"      \ 'simple' : 1,
"      \ 'menu_fmt' : '@year, @author_short, @title',
"      \}
"let g:vimtex_echo_verbose_input = 0

" ====== MY MAPPINGS ======
" inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"


map <Leader><Leader> :FZF -e -i -q 
nnoremap <Leader>rf :! %:p:r<Enter>

nmap <F8> :TagbarToggle<cr>
nmap <F7> :NERDTreeToggle<cr>


nmap <Leader>cp gcap
nmap <Leader>uc gcgc
nmap <Leader>cl <Plug>CommentaryLine
nmap <Leader>g :Goyo<Enter> 

" --- Easymotion --- "
" nmap <Leader>w <Plug>(easymotion-bd-w)
nmap s <Plug>(easymotion-bd-w)
nmap <Leader>s <Plug>(easymotion-s)
nmap <Leader>e <Plug>(easymotion-prefix)
let g:EasyMotion_keys = 'oqukliwcademsjf'

" -- Easyoperator -- "
" nmap <Leader>d <Plug>(easyoperator-line-delete)

"-- Tabbing --"
nmap <Leader>tt :tabedit<Enter>:FZF -e -i -q 
nmap <C-n> :tabn<Enter>
nmap <C-b> :tabp<Enter>
nmap <Leader>tc :tabclose<Enter>

" -- yank-paste-comment --"
nmap <Leader>cy yypk<Leader>clj

"-- TODO jumping --"
nmap t :/\ctodo<Enter>:noh<Enter>z<Enter>7k8j
nmap T oTODO<ESC><space>cleea: 

"-- Folding --"
nmap <C-k> zk
nmap <C-j> zj
nmap <C-s> zA
nmap <F2> :set foldmethod=syntax<Enter>


" Navigating (luke smith)
"
    inoremap ,, <Esc>/<++><Enter>"_c4l
    vnoremap ,, <Esc>/<++><Enter>"_c4l
	map ,, <Esc>/<++><Enter>"_c4l

"""LATEX (luke smith)
	autocmd FileType tex map <leader>w :w !detex \| wc -w<CR>
	autocmd FileType tex inoremap ,em \emph{}<++><Esc>T{i
	autocmd FileType tex inoremap ,bf \textbf{}<++><Esc>T{i
	autocmd FileType tex inoremap ,it \textit{}<++><Esc>T{i
	autocmd FileType tex inoremap ,tc \textcite{}<++><Esc>T{i
	autocmd FileType tex inoremap ,pc \parencite{}<++><Esc>T{i
	autocmd FileType tex inoremap ,en \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><Esc>3kA\item<Space>
	autocmd FileType tex inoremap ,iz \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><Esc>3kA\item<Space>
	autocmd FileType tex inoremap ,ma \begin{math}<Enter><Enter>\end{math}<Enter><Enter><++><Esc>3kA<Tab>
	autocmd FileType tex inoremap ,fr \frac{}{<++>}<++><Esc>ba
	autocmd FileType tex inoremap ,li <Enter>\item<Space>

	autocmd FileType tex inoremap ,2i <Enter>\item<Space><Enter>\item<Space><++><Esc>ka
	autocmd FileType tex inoremap ,3i <Enter>\item<Space><Enter>\item<Space><++><Enter>\item<Space><++><Esc>2ka
	autocmd FileType tex inoremap ,4i <Enter>\item<Space><Enter>\item<Space><++><Enter>\item<Space><++><Enter>\item<Space><++><Esc>3ka
	autocmd FileType tex inoremap ,5i <Enter>\item<Space><Enter>\item<Space><++><Enter>\item<Space><++><Enter>\item<Space><++><Enter>\item<Space><++><Esc>4ka

	autocmd FileType tex inoremap ,ref \ref{}<Space><++><Esc>T{i
	autocmd FileType tex inoremap ,tab \begin{tabular}<Enter><++><Enter>\end{tabular}<Enter><Enter><++><Esc>4kA{}<Esc>i
	autocmd FileType tex inoremap ,a \href{}{<++>}<Space><++><Esc>2T{i
	autocmd FileType tex inoremap ,sc \textsc{}<Space><++><Esc>T{i
	autocmd FileType tex inoremap ,chap \chapter{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ,se \section{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ,sse \subsection{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ,ssse \subsubsection{}<Enter><Enter><++><Esc>2kf}i

    " Install mult cursors
	" autocmd FileType tex inoremap ,beg \begin{DELRN}<Enter><++><Enter>\end{DELRN}<Enter><Enter><++><Esc>4k0fR:MultipleCursorsFind<Space>DELRN<Enter>c

	autocmd FileType tex inoremap ,up <Esc>/usepackage<Enter>o\usepackage{}<Esc>i
	autocmd FileType tex nnoremap ,up /usepackage<Enter>o\usepackage{}<Esc>i
	autocmd FileType tex inoremap ,tt \texttt{}<Space><++><Esc>T{i
	autocmd FileType tex inoremap ,rn (\ref{})<++><Esc>F}i
