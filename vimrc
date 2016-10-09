" vime fen fdm=marker fdl=1
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
let maplocalleader = "\<BS>"

set path=.,,**

set mouse=a

" Convenient to :save or :write a copy of a file to the same directory.
autocmd BufEnter * silent! lcd %:p:h

" Exploit semifuzzy `:find` files.
" Construct the path:
" 1. find first .git directory upwards
" 2. set it as a first dir in path
" 3. add 'fuzziness' with /**
" Once you've opened the file in a nested dir you would be able to :find
" other*file*s related to a .git directory.
fun! MakePathToDotGit()
	let path = fnamemodify(finddir(".git", ".;"), ":p:h:h")
	" Unfortunately `finddir` do not indicate whether it has found a dir or
	" not. This check is fragile and tested only in Windows.
	" Constructing semi-semi fuzzy path: files would be searched from the
	" CURRENT file's directory.
	if path == expand("$VIM")
		return ".,**"
	endif

	" Windows paths are evil.
	let path = substitute(path, '\\', '/', "g")
	" Spaces should be escaped.
	let path = substitute(path, ' ', '\\\\\\ ', "g")
	" The `Fuzzy` path is ready.
	return path."/**,."
endfun
autocmd BufEnter * let &l:path = MakePathToDotGit()

" UI {{{1
set shortmess+=I
set winaltkeys=no
set guioptions=cm " No toolbar
set laststatus=2
set showtabline=1
set cmdheight=1
set number
set norelativenumber
set winminwidth=0 winminheight=0
set lazyredraw
set splitbelow
set diffopt+=vertical
set nofoldenable
set foldminlines=1 foldlevel=1
set scrolloff=1 sidescrolloff=5
set display+=lastline
set tabpagemax=50

" default ASCII listchars
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+,eol:$
" UTF-8 symbols, good font needed
" set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨
" set showbreak=↪\<space>

if has("gui_running")
	if has("gui_macvim")
		set gfn=Input:h14,Menlo:h14
		set macmeta
		let macvim_skip_colorscheme = 1
	elseif has("unix")
		set gfn=Input\ 12,DejaVu\ Sans\ Mono\ 12,Monospace\ 12
	else
		set gfn=Input:h12,Consolas:h12
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

" inoremap ii <ESC>
" vnoremap ii <ESC>
" inoremap шш <ESC>
" vnoremap шш <ESC>

" Allows incsearch highlighting for range commands
" This is just a convenient shorthand of :/foobar/t.  :/foobar/m. and :/foobar/d
" use regular search to locate the line you want to
" Copy to current position
cnoremap $t <CR>:t''<CR>
" Move to current position
cnoremap $m <CR>:m''<CR>
" or Delete
cnoremap $d <CR>:d<CR>``

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

nnoremap <Leader>fd :cd %:p:h<CR>:pwd<CR>

" System clipboard
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P
vnoremap <Leader>y "+y
nnoremap <Leader>yy "+yy

" init file AKA vimrc
noremap <Leader>foi :e $MYVIMRC<CR>
noremap <Leader>foe :Ex<CR>
noremap <Leader>fs :up<CR>


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
set keymap=russian-jcukenwin
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
if has('win32') && has('langmap')
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
	runtime neo.vim
endif

" Abbreviations {{{1
runtime abbreviations.vim

" Plugins {{{1
" load plugins with vim-plug
runtime plugins.vim

" Colors {{{1
silent! colorscheme kosmos
" silent! colorscheme base16-tomorrow-night

" temporary helper bindings to design colorscheme
noremap <leader>ac :colo kosmos<CR>
noremap <leader>foc :e ~/*vim*/**/kosmos.vim<CR>
noremap <leader>sh :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
		\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
		\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
