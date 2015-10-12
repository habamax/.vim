" vim: fen fdm=marker fdl=1
" Author: Maxim Kim <habamax@gmail.com>

" Must have {{{1
set nocompatible
if has('autocmd')
	autocmd!
	filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
	syntax enable
endif

set hidden
set confirm
set browsedir=buffer

let mapleader = "\<Space>"

set mouse=a

" NeoVim handles ESC keys as alt+key, set this to solve the problem
if has('nvim')
	set ttimeout
	set ttimeoutlen=0
endif

" UI {{{1
set shortmess+=I
set winaltkeys=no
set guioptions-=T " No toolbar
set laststatus=2
set showtabline=1
set cmdheight=1
set number
set relativenumber
set winminwidth=0 winminheight=0
set lazyredraw
set splitbelow
set diffopt+=vertical
set nofoldenable
set foldminlines=1 foldlevel=1
set scrolloff=1 sidescrolloff=5
set display+=lastline
set tabpagemax=50

set listchars=tab:→\ ,trail:-,extends:>,precedes:<,nbsp:+

if has("gui_running")
	if has("gui_macvim")
		set gfn=Source\ Code\ Pro:h14
		set macmeta
		let macvim_skip_colorscheme = 1
	elseif has("unix")
		set gfn=DejaVu\ Sans\ Mono\ 12,Monospace\ 12
	endif
endif

" autocomplete is getting much better :e <tab>...
set wildchar=<Tab> wildmenu wildmode=full
set wildignore=*.o,*.obj,*.bak,*.exe,*.swp

" turn off beeping...
set visualbell
au GuiEnter * set t_vb=
set t_vb=


" Text {{{1
set encoding=utf8
set fileencoding=utf8
set fileformats=unix,mac,dos
set fileformat=unix

set tabstop=8 shiftwidth=8 noexpandtab nosmarttab
set shiftround
set autoindent
set hlsearch incsearch ignorecase
set nowrap
set nojoinspaces
set linebreak

set spelllang=ru,en
set nospell

set clipboard=unnamed

" backspace and cursor keys wrap to previous/next line
set backspace=indent,eol,start whichwrap+=<,>,[,]

set formatoptions+=nroj
set comments=n:>,fb:-,fb:*
set formatlistpat=^\\s\\+[*#-]\\s*

" Backup & Undo & Sessions {{{1
let s:other_dir = expand('~/.vim_other')
if !isdirectory(s:other_dir)
	call mkdir(s:other_dir)
endif
if !isdirectory(s:other_dir.'/.vim_backups')
	call mkdir(s:other_dir.'/.vim_backups')
endif
if !isdirectory(s:other_dir.'/.vim_undo')
	call mkdir(s:other_dir.'/.vim_undo')
endif

set backup
let &backupdir = s:other_dir . '/.vim_backups/'
let &directory = s:other_dir . '/.vim_backups/,.'

set undofile
let &undodir = s:other_dir . '/.vim_undo/,.'

" Mappings {{{1
inoremap ii <ESC>
inoremap шш <ESC>

" Regular enhancements {{{2
noremap k gk
vnoremap k gk
noremap j gj
vnoremap j gj
vnoremap > >gv
vnoremap < <gv

" Text operations {{{2
" Capitalize Inner word
nnoremap <leader>tc :CapitalizeWord<CR>
" UPPERCASE inner word
nnoremap <leader>tu :UppercaseWord<CR>
" lowercase inner word
nnoremap <leader>tl :LowercaseWord<CR>

" just one space on the line, preserving indent
nnoremap <leader>tos :JustOneInnerSpace<CR>
" remove trailing spaces
nnoremap <leader>tts :RemoveTrailingSpaces<CR>

" Files {{{2
" saving file
nnoremap <leader>fs :update<CR>

nnoremap <Leader>fd :Explore<CR>

" init file AKA vimrc
noremap <Leader>fi :e $MYVIMRC<CR>

" Buffers {{{2
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
" delete buffer
nnoremap <leader>bd :bd<CR>
nnoremap <leader>bk :bd!<CR>

" Exiting {{{2
nnoremap <leader>qq :q<CR>
nnoremap <leader>qw :wq<CR>
nnoremap <leader>qu :qa!<CR>

" Terminal {{{2
tnoremap <C-o> <C-\><C-n>

" Misc {{{2
" now it is possible to paste many times over selected text
xnoremap <expr> p 'pgv"'.v:register.'y'

" <C-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR>:diffupdate<CR><C-l>

" Underline current line "{{{
nnoremap <leader>- "zyy"zp<c-v>$r-
nnoremap <leader>= "zyy"zp<c-v>$r=
nnoremap <leader><leader>- o<home><ESC>120i-<ESC>
nnoremap <leader><leader>= o<home><ESC>120i=<ESC>
"}}}

" find visually selected text
vnoremap * y/<C-R>"<CR>

" replace word under cursor
nnoremap <Leader>tr :%s/\<<C-R><C-W>\>//gc<Left><Left><Left>

" nnoremap <Leader>tn :tabnew<CR>
nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>

" run selected vimscript
vnoremap <Leader>rv "vy:@v<CR>
" run vimscript line
nnoremap <Leader>rv "vyy:@v<CR>
" run .vimrc
nnoremap <Leader>ri :source $MYVIMRC<CR>

nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>

" System clipboard
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P
vnoremap <Leader>y "+y
nnoremap <Leader>yy "+yy

" Commands {{{1

" remove trailing spaces
" make a separate plugin for the commands
command! RemoveTrailingSpaces :silent! %s/\v(\s+$)|(\r+$)//g<bar>
		\:exe 'normal ``'<bar>
		\:echo 'Remove trailing spaces and ^Ms.'

command! JustOneInnerSpace :let pos=getpos('.')<bar>
		\:silent! s/\S\+\zs\s\+/ /g<bar>
		\:silent! s/\s$//<bar>
		\:call setpos('.', pos)<bar>
		\:nohl<bar>
		\:echo 'Just one space'

command! CapitalizeWord :let pos=getpos('.')<bar>
		\:exe 'normal guiw~'<bar>
		\:call setpos('.', pos)

command! UppercaseWord :let pos=getpos('.')<bar>
		\:exe 'normal gUiw'<bar>
		\:call setpos('.', pos)

command! LowercaseWord :let pos=getpos('.')<bar>
		\:exe 'normal guiw'<bar>
		\:call setpos('.', pos)

" Netrw settings {{{1
let g:netrw_silent = 1
let g:netrw_keepdir = 0
let g:netrw_special_syntax = 1
let g:netrw_list_hide = "\.pyc$,\.swp$,\.bak$"
let g:netrw_retmap = 1

" Plugins {{{1
" Vim-Plug bootstrapping. {{{2
" Don't forget to call :PlugInstall
let g:vim_plug_installed = filereadable(expand('~/.vim/autoload/plug.vim'))
if !g:vim_plug_installed
	echomsg "Install vim-plug with 'InstallVimPlug' command and restart vim."
	echomsg "'curl' should be installed first"
	command InstallVimPlug !mkdir -p ~/.vim/autoload |
			\ curl -fLo ~/.vim/autoload/plug.vim
			\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Do not load plugins if plugin manager is not installed.
if !g:vim_plug_installed
	finish
endif

" Here be plugins {{{2
call plug#begin('~/.vim/plugged')
let g:plug_timeout = 180

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'
" Set up FZF {{{3
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

fun! s:fzf_root()
	let path = finddir(".git", expand("%:p:h").";")
	return fnamemodify(substitute(path, ".git", "", ""), ":p:h")
endfun

nnoremap <silent> <Leader>ff :exe 'Files ' . <SID>fzf_root()<CR>
nnoremap <silent> <Leader>fc :Colors<CR>
nnoremap <silent> <Leader>fh :History<CR>
nnoremap <silent> <Leader>bb :Buffers<CR>
nnoremap <silent> <Leader>; :Commands<CR>
nnoremap <silent> <Leader>h :Helptags<CR>
nnoremap <silent> <Leader>ll :Lines<CR>
nnoremap <silent> <Leader>lb :BLines<CR>

"}}}

Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --gocode-completer --omnisharp-completer' }
"Plug 'Shougo/neocomplete.vim' "{{{
"let g:neocomplete#enable_at_startup = 1
"let g:neocomplete#enable_smart_case = 1
"let g:neocomplete#enable_auto_select = 0
"let g:neocomplete#enable_auto_delimiter = 1
"" Recommended key-mappings.
"" <CR>: close popup and save indent.
"inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"function! s:my_cr_function()
"	return neocomplete#close_popup() . "\<CR>"
"endfunction
"" <TAB>: completion.
"inoremap <expr><TAB>p umvisible() ? "\<C-n>" : "\<TAB>"
"" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
"inoremap <expr><C-y> neocomplete#close_popup()
"inoremap <expr><C-e> neocomplete#cancel_popup()
""}}}

Plug 'vimwiki/vimwiki', {'branch': 'dev'}

Plug 'benekastah/neomake'
" {{{
  autocmd! BufWritePost * Neomake
  " let g:neomake_airline = 0
  let g:neomake_error_sign = { 'text': '✘', 'texthl': 'ErrorSign' }
  let g:neomake_warning_sign = { 'text': ':(', 'texthl': 'WarningSign' }

  " map <F4> :lopen<CR>
  map <leader>rm :Neomake<CR>
" }}}

Plug 'Raimondi/delimitMate'
let delimitMate_expand_space = 1
let delimitMate_expand_cr = 2

Plug 'junegunn/vim-easy-align'
let g:easy_align_ignore_comment = 0 " align comments
vnoremap <silent> <Enter> :EasyAlign<cr>
nmap ga <Plug>(EasyAlign)

Plug 'junegunn/rainbow_parentheses.vim'
nnoremap <leader>xp :RainbowParentheses!!<CR>

Plug 'michaeljsmith/vim-indent-object'

Plug 'tmhedberg/matchit'

" Tim Pope is a beast. You better use his stuff ...
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-fugitive'
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gw :Gwrite<CR>

Plug 'habamax/vim-russian-jcukenmac'
" Plug 'habamax/vim-skipit'
Plug '~/work/vim/vim-skipit/'

Plug 'ledger/vim-ledger'
let g:ledger_maxwidth = 80
let g:ledger_default_commodity = 'RUR'
let g:ledger_commodity_before = 0
let g:ledger_commodity_sep = ' '
command LedgerReportBalance :!ledger bal -f ~/accounting/family.ledger
" reports:
" ledger reg --date-format [%Y-%m-%d] -f family.ledger
" ledger bal -f family.ledger
" use formatexpr to gqap posting...



" Colorschemes"{{{
Plug 'jnurmine/Zenburn'
Plug 'NLKNguyen/papercolor-theme'
Plug 'romainl/Apprentice'
Plug 'nanotech/jellybeans.vim'
Plug 'sjl/badwolf'
Plug 'w0ng/vim-hybrid'
Plug 'endel/vim-github-colorscheme'

Plug 'morhetz/gruvbox'
let g:gruvbox_invert_selection = 0
"}}}

Plug 'bling/vim-airline'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1


call plug#end()

" Keymap {{{1
" plugin should be installed...
" Однажды в студеную зимнюю пору я из лесу вышел -- был сильный мороз.
set keymap=russian-jcukenmac
set iminsert=0
set imsearch=0

" Russian langmap for OSX
set langmap=йцукенгшщзхъ;qwertyuiop[]
set langmap+=фывапролджэё;asdfghjkl\\;'\\\
set langmap+=ячсмитьбю;zxcvbnm\\,.
set langmap+=ЙЦУКЕНГШЩЗХЪ;QWERTYUIOP{}
set langmap+=ФЫВАПРОЛДЖЭЁ;ASDFGHJKL\\:\\"\\|
set langmap+=ЯЧСМИТЬБЮ;ZXCVBNM<>
set langmap+=№#


" Colors"{{{1
set background=dark
silent! colorscheme gruvbox
