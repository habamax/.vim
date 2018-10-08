" vim: fen fdm=marker fdl=1
" Author: Maxim Kim <habamax@gmail.com>

" Must have {{{1
set nocompatible

" menus will be in english
set langmenu=en_US.UTF8
" everything else will be in english too
language en

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
let maplocalleader = "\<BS>"

set mouse=a

" Convenient to :save or :write a copy of a file to the same directory.
autocmd BufEnter * silent! lcd %:p:h


" UI {{{1
set shortmess+=I
set winaltkeys=no
set guioptions=cm " No toolbar
set laststatus=2
set showtabline=1
set cmdheight=1
set number
" set relativenumber
set winminwidth=0 winminheight=0
set lazyredraw
set splitbelow
set diffopt+=vertical
set nofoldenable
set foldminlines=1 foldlevel=1
" set scrolloff=1 sidescrolloff=5
set display+=lastline
set tabpagemax=50

" default ASCII listchars
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+,eol:$
" UTF-8 symbols, good font needed
" set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨
" set showbreak=↪\<space>

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

set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab nosmarttab
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

set formatoptions=tcqnroj
" tune it for asciidoctor
" set comments=n:>,n:-,n:*
" set formatlistpat=^\\s\\+[*#-]\\s*

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

" inoremap ii <ESC>
" vnoremap ii <ESC>
" inoremap шш <ESC>
" vnoremap шш <ESC>

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" just one space on the line, preserving indent
nnoremap <leader>tos :JustOneInnerSpace<CR>
" remove trailing spaces
nnoremap <leader>tts :RemoveTrailingSpaces<CR>


" now it is possible to paste many times over selected text
xnoremap <expr> p 'pgv"'.v:register.'y'

" <C-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR>:diffupdate<CR><C-l>


" Underline current line
nnoremap <leader>- "zyy"zp<c-v>$r-
nnoremap <leader>= "zyy"zp<c-v>$r=
nnoremap <leader><leader>- o<home><ESC>100i-<ESC>
nnoremap <leader><leader>= o<home><ESC>100i=<ESC>

" find visually selected text
vnoremap * y/<C-R>"<CR>

" substitute word under cursor
nnoremap <Leader>ts :%s/\<<C-R><C-W>\>//gc<Left><Left><Left>

" eval selected vimscript
vnoremap <Leader>ee "vy:@v<CR>
" eval vimscript line
nnoremap <Leader>ee "vyy:@v<CR>
" eval .vimrc
" nnoremap <Leader>ev :source $MYVIMRC<CR>

" nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>

" open init file (vimrc)
noremap <Leader>fvi :e $MYVIMRC<CR>
" open gvim init file (gvimrc)
noremap <Leader>fvg :exe "e ".fnamemodify($MYVIMRC, ":p:h")."/gvimrc"<CR>
" open plugins file
noremap <Leader>fvp :exe "e ".fnamemodify($MYVIMRC, ":p:h")."/plugins.vim"<CR>

" open global notes file
noremap <Leader>fn :e ~/docs/notes.adoc<CR>


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


" внутренняя раскладка (keymap)
if has('osx')
	set keymap=russian-jcukenmac
else
	set keymap=russian-jcukenwin
endif
set iminsert=0
set imsearch=-1

" Langmap {{{1
" Russian langmap for OSX
" set langmap=йцукенгшщзхъ;qwertyuiop[]
" set langmap+=фывапролджэё;asdfghjkl\\;'\\\
" set langmap+=ячсмитьбю;zxcvbnm\\,.
" set langmap+=ЙЦУКЕНГШЩЗХЪ;QWERTYUIOP{}
" set langmap+=ФЫВАПРОЛДЖЭЁ;ASDFGHJKL\\:\\"\\|
" set langmap+=ЯЧСМИТЬБЮ;ZXCVBNM<>
" set langmap+=№#

" Russian langmap for standard PC keyboard
if has('langmap')
	set langmap=йцукенгшщзхъ;qwertyuiop[]
	set langmap+=фывапролджэё;asdfghjkl\\;'\\\
	set langmap+=ячсмитьбю;zxcvbnm\\,.
	set langmap+=ЙЦУКЕНГШЩЗХЪ;QWERTYUIOP{}
	set langmap+=ФЫВАПРОЛДЖЭЁ;ASDFGHJKL\\:\\"\\~
	set langmap+=ЯЧСМИТЬБЮ;ZXCVBNM<>
	set langmap+=№#
endif

" Create dirs on file save {{{1
function! s:MkNonExDir(file, buf)
	if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
		let dir=fnamemodify(a:file, ':h')
		if !isdirectory(dir)
			call mkdir(dir, 'p')
		endif
	endif
endfunction
augroup BWCCreateDir
	autocmd!
	autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

" neovim specific {{{1
if has('nvim')
	set inccommand=split
endif

if executable('rg')
	set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
endif

" Abbreviations {{{1
runtime abbreviations.vim

" Plugins {{{1
" load plugins with vim-plug
runtime plugins.vim
