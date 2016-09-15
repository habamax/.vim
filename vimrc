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

" UI {{{1
set shortmess+=I
set winaltkeys=no
set guioptions=m " No toolbar
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

set listchars=tab:>-,trail:-,extends:>,precedes:<,nbsp:+,eol:$

if has("gui_running")
	if has("gui_macvim")
		set gfn=Source\ Code\ Pro:h14
		set macmeta
		let macvim_skip_colorscheme = 1
	elseif has("unix")
		set gfn=DejaVu\ Sans\ Mono\ 12,Monospace\ 12
	else
		set gfn=Source\ Code\ Pro:h12,Consolas:h12
		" set renderoptions=type:directx
	endif
	set columns=999
	set lines=999
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

set tabstop=4 shiftwidth=4 noexpandtab nosmarttab
set shiftround
set autoindent
set hlsearch incsearch ignorecase
set wrap
set nojoinspaces
set linebreak
set breakindent
set virtualedit=block

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
vnoremap ii <ESC>
inoremap шш <ESC>
vnoremap шш <ESC>

" Regular enhancements {{{2
noremap k gk
vnoremap k gk
noremap j gj
vnoremap j gj
vnoremap > >gv
vnoremap < <gv

" Text operations {{{2
" just one space on the line, preserving indent
nnoremap <leader>tos :JustOneInnerSpace<CR>
" remove trailing spaces
nnoremap <leader>tts :RemoveTrailingSpaces<CR>

" init file AKA vimrc
noremap <Leader>fi :e $MYVIMRC<CR>


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

" Langmap {{{1
" Russian langmap for OSX
" set langmap=йцукенгшщзхъ;qwertyuiop[]
" set langmap+=фывапролджэё;asdfghjkl\\;'\\\
" set langmap+=ячсмитьбю;zxcvbnm\\,.
" set langmap+=ЙЦУКЕНГШЩЗХЪ;QWERTYUIOP{}
" set langmap+=ФЫВАПРОЛДЖЭЁ;ASDFGHJKL\\:\\"\\|
" set langmap+=ЯЧСМИТЬБЮ;ZXCVBNM<>
" set langmap+=№#
" set langmap+=./
" set langmap+=\\,?

" Russian langmap for Windows
if has('win32') && has('langmap')
	set langmap=йцукенгшщзхъ;qwertyuiop[]
	set langmap+=фывапролджэё;asdfghjkl\\;'\\\
	set langmap+=ячсмитьбю;zxcvbnm\\,.
	set langmap+=ЙЦУКЕНГШЩЗХЪ;QWERTYUIOP{}
	set langmap+=ФЫВАПРОЛДЖЭЁ;ASDFGHJKL\\:\\"\\|
	set langmap+=ЯЧСМИТЬБЮ;ZXCVBNM<>
	set langmap+=№#
endif

" neovim specific
if has('nvim')
	runtime neo.vim
endif

" Plugins {{{1
" load plugins with vim-plug
runtime plugins.vim

" Colors"{{{2
silent! colorscheme kosmos
" helper to design colorscheme
noremap <leader>cc :colo kosmos<CR>
noremap <leader>co :e ~/*vim*/**/kosmos.vim<CR>
noremap <leader>ch :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
		\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
		\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
