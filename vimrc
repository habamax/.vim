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

" Encoding and fileformat {{{1
set encoding=utf8
set fileencoding=utf8
set fileformats=unix,mac,dos
set fileformat=unix

" UI {{{1
if !has("gui_running")
	colo industry
endif
set shortmess+=I
set winaltkeys=no
set guioptions=cm " No toolbar
set laststatus=2
set ruler " for default statusline"
set showtabline=1
set cmdheight=1
set nonumber
" set relativenumber
set winminwidth=0 winminheight=0
set lazyredraw
set splitbelow
set splitright
set diffopt+=vertical
set nofoldenable
set foldminlines=1 foldlevel=1
" set scrolloff=1 sidescrolloff=5
set display+=lastline
set tabpagemax=50

" default ASCII listchars
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+,eol:$
" UTF-8 symbols, good font needed"{{{
set listchars=tab:→\ ,eol:↲,trail:·,extends:⟩,precedes:⟨
set showbreak=↪
set list

set fillchars=vert:│

" My fancy foldtext
set foldtext=MyFoldText()
fu! MyFoldText()
  let line = getline(v:foldstart)
  let sub = substitute(line, '^//\|["#]\|/\*\|\*/\|{{{\d\=', '', 'g')
  let sub = substitute(sub, '^[[:space:]]*\|[[:space:]]*$', ' ', 'g')
  return repeat('▷', v:foldlevel) . sub .'{'. (v:foldend - v:foldstart + 1) .'} '
  " ★◆▷▶
endfu
"}}}

" autocomplete is getting much better :e <tab>...
set wildchar=<Tab> wildmenu wildmode=full
set wildignore=*.o,*.obj,*.bak,*.exe,*.swp

" turn off beeping...
set visualbell
au! GuiEnter * set t_vb=
set t_vb=

" Text {{{1
set tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab smarttab
set shiftround
set autoindent
set hlsearch incsearch ignorecase
set wrap
set nojoinspaces
set linebreak
set breakindent
set breakindentopt=sbr " showbreak will be handled correctly
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
if !has("nvim")
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
endif

" Mappings {{{1

inoremap <C-space> <esc>
vnoremap <C-space> <esc>
onoremap <C-space> <esc>
tnoremap <C-space> <C-\><C-N>
cnoremap <C-space> <C-c><esc>
inoremap <S-space> <esc>
vnoremap <S-space> <esc>
onoremap <S-space> <esc>
tnoremap <S-space> <C-\><C-N>
cnoremap <S-space> <C-c><esc>

" CTRL-U in insert mode deletes a lot.	Use CTRL-G u to first break undo,
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

" nnoremap <Leader>ev :source $MYVIMRC<CR>

" nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>

" open init file (vimrc)
noremap <Leader>fvi :e $MYVIMRC<CR>
" open gvim init file (gvimrc)
noremap <Leader>fvg :e $MYGVIMRC<CR>
" open plugins settings file
noremap <Leader>fvs :exe "e ".fnamemodify($MYVIMRC, ":p:h")."/plugins.vim"<CR>
" open plugins list file
noremap <Leader>fvp :exe "e ".fnamemodify($MYVIMRC, ":p:h")."/minpac_list.vim"<CR>

" open global notes file
noremap <Leader>fn :e ~/docs/notes.adoc<CR>

" built-in terminal
tnoremap <esc> <C-\><C-n>

nnoremap <Leader><tab> :bn<CR>
nnoremap <Leader><leader><tab> :bp<CR>


" Window movements
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
tnoremap <A-h> <C-w>h
tnoremap <A-j> <C-w>j
tnoremap <A-k> <C-w>k
tnoremap <A-l> <C-w>l

" temporary here

fun! s:findnext(pattern)
	" c - accept matches at the current cursor
	return searchpos(a:pattern, 'ecW')
endfun

fun! s:haba_open_below()
	let pattern='\v[)}\]]'
	let pos = s:findnext(pattern)

	if pos != [0, 0]
		call setpos('.', [0, pos[0], pos[1], 0])
		startinsert
	endif
endfun

nnoremap go :call <sid>haba_open_below()<CR><right><CR>
" TODO: make gO, move it to a separate package

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
" set langmap+=№#
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
fu! s:MkNonExDir(file, buf)
	if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
		let dir=fnamemodify(a:file, ':h')
		if !isdirectory(dir)
			call mkdir(dir, 'p')
		endif
	endif
endfu

augroup BWCCreateDir
	autocmd!
	autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

" neovim specific {{{1
if has('nvim')
	set inccommand=split
endif

" if executable('rg')
"	set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
" endif

" Abbreviations {{{1
runtime abbreviations.vim

" Plugins {{{1
" load plugins
runtime plugins.vim
