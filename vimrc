" Author: Maxim Kim <habamax@gmail.com>

" Must have {{{1
set nocompatible

" menus will be in english
set langmenu=en_US.UTF8
" everything else will be in english too
language en

filetype plugin indent on

if has('autocmd')
	autocmd!
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
" autocmd BufEnter * silent! lcd %:p:h
" set autochdir

" Encoding and fileformat {{{1
set encoding=utf8
set fileencoding=utf8
set fileformats=unix,mac,dos
set fileformat=unix

" UI {{{1
set shortmess+=Ic
set winaltkeys=no
set guioptions=cme
set laststatus=2
set ruler " for default statusline"
set showtabline=1
set cmdheight=1
set nonumber norelativenumber
set winminwidth=0 winminheight=0
set lazyredraw
set splitbelow
set splitright
if !has('nvim') && has('patch-8.1.360')
	set diffopt=internal,filler,vertical,algorithm:patience
else
	set diffopt=filler,vertical
endif
" mucomplete needs this
set completeopt+=menuone,noselect
set nofoldenable
set foldminlines=1 foldlevel=1
set scrolloff=2 sidescrolloff=5
set display+=lastline
set tabpagemax=50
" turn off if you use airline
set showmode

" Unicode chars {{{
" default ASCII listchars
" set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+,eol:$
" UTF-8 symbols, good font needed
" set listchars=tab:→\ ,eol:↲,trail:·,extends:⟩,precedes:⟨
set listchars=tab:→\ ,eol:┐,trail:·
set showbreak=╰
set nolist
" ╙⇾●➠➥➝➙⇰↪⊂➘↳→│↑←↓↘➝┐↙
set fillchars=fold:\ ,vert:│

" My fancy foldtext
set foldtext=MyFoldText()
fu! MyFoldText()
	let line = getline(v:foldstart)
	let indent = max([indent(v:foldstart)-v:foldlevel, 1])
	let lines = (v:foldend - v:foldstart + 1)
	let sub = substitute(line, '^//\|=\+\|["#]\|/\*\|\*/\|{{{\d\=', '', 'g')
	let sub = substitute(sub, '^[[:space:]]*\|[[:space:]]*$', '', 'g')
	let text = strpart(sub, 0, winwidth(0) - v:foldlevel - indent - 6 - strlen(lines))
	if strlen(sub) > strlen(text)
		let text = text.'…'
	endif
	return repeat('▢', v:foldlevel) . repeat(' ', indent) . text .' ('. lines .')'
	" ▸•●□★▢▧▪◆▷▶┄◇
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
set tabstop=4 softtabstop=-1 shiftwidth=0 noexpandtab smarttab
set shiftround
set autoindent

set nohlsearch incsearch ignorecase
" highlight all occurencies of a term being searched/replaced
augroup hlsearch-incsearch
	autocmd!
	autocmd CmdlineEnter /,\?,: :set hlsearch
	autocmd CmdlineLeave /,\?,: :set nohlsearch
augroup END

set wrap
set nojoinspaces
set linebreak
set breakindent
set breakindentopt=sbr " showbreak will be handled correctly
set virtualedit=block

" neovim specific
if has('nvim')
	set inccommand=split
endif

set spelllang=ru,en
set nospell

set clipboard=unnamed

" backspace and cursor keys wrap to previous/next line
set backspace=indent,eol,start whichwrap+=<,>,[,]

set formatoptions=tcqnroj

" Encryption {{{1
if has('crypt-blowfish2')
	set cryptmethod=blowfish2
endif

" Backup & Undo & Sessions {{{1
if !has("nvim")
	let s:other_dir = expand('~/.vimdata')
	if !isdirectory(s:other_dir)
		call mkdir(s:other_dir)
	endif
	if !isdirectory(s:other_dir.'/backup')
		call mkdir(s:other_dir.'/backup')
	endif
	if !isdirectory(s:other_dir.'/undo')
		call mkdir(s:other_dir.'/undo')
	endif
	if !isdirectory(s:other_dir.'/swap')
		call mkdir(s:other_dir.'/swap')
	endif

	set backup
	let &backupdir = s:other_dir . '/backup//'
	let &directory = s:other_dir . '/swap//,.'

	set undofile
	let &undodir = s:other_dir . '/undo//,.'
endif

" Mappings {{{1

" Easier keymap switch, Да.
inoremap <C-l> <C-^>
cnoremap <C-l> <C-^>

" CTRL-U in insert mode deletes a lot.	Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" just one space on the line, preserving indent
" nnoremap <leader>tos :JustOneInnerSpace<CR>

" now it is possible to paste many times over selected text
xnoremap <expr> p 'pgv"'.v:register.'y'

" change current word (like ciw) but repeatable with dot . for the same next
" word
nnoremap <silent> c<Tab> :let @/=expand('<cword>')<cr>cgn

" <C-l> redraws the screen and removes any search highlighting.
" nnoremap <silent> <C-l> :nohl<CR>:diffupdate<CR><C-l>


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
nnoremap <Leader>fvi :e $MYVIMRC<CR>
" open gvim init file (gvimrc)
nnoremap <Leader>fvg :e $MYGVIMRC<CR>
" open plugins settings file
nnoremap <Leader>fvs :exe "e ".fnamemodify($MYVIMRC, ":p:h")."/plugins.vim"<CR>
" open plugins list file
nnoremap <Leader>fvp :exe "e ".fnamemodify($MYVIMRC, ":p:h")."/minpac_list.vim"<CR>

" open global notes file
nnoremap <Leader>fn :e ~/docs/notes/notes.adoc<CR>

" open projects file
nnoremap <Leader>fp :e ~/docs/projects.adoc<CR>

" built-in terminal
tnoremap <esc> <C-\><C-n>

nnoremap <Leader><tab> <C-^>
nnoremap <Leader><leader>t :tabnew<CR>

nnoremap <Leader>cd :lcd %:p:h <bar> pwd<CR>

" Window movements
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
tnoremap <A-h> <C-w>h
tnoremap <A-j> <C-w>j
tnoremap <A-k> <C-w>k
tnoremap <A-l> <C-w>l

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

" Not for Windows
" Write to a privileged file
if has("unix") || has("osxdarwin")
	command! W w !sudo tee "%" > /dev/null
endif


" RU {{{1
" Keymap внутренняя раскладка
if has('osx')
	set keymap=russian-jcukenmac
else
	set keymap=russian-jcukenwin
endif
set iminsert=0
set imsearch=-1

" Langmap
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

" Load Plugins and Abbreviations {{{1
" source <sfile>:h/abbreviations.vim
runtime abbreviations.vim

" source <sfile>:h/plugins.vim
runtime plugins.vim
