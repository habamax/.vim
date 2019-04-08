" Author: Maxim Kim <habamax@gmail.com>

" Must have {{{1
set nocompatible

" Everything will be in English
language messages en_US.UTF-8

filetype plugin indent on

if has('autocmd')
	autocmd!
endif
if &t_Co > 2 || has("gui_running")
	syntax on
endif

set hidden
set confirm
set browsedir=buffer

let mapleader = "\<Space>"
let maplocalleader = "\<BS>"

if has('mouse')
	set mouse=a
endif

" Encoding and fileformat {{{1
set encoding=utf8
set fileencoding=utf8
set fileformats=unix,mac,dos
set fileformat=unix

" UI {{{1
if !has("gui_running")
	if exists('+termguicolors')
		set termguicolors
	else
		set t_Co=256
	endif
	" for terminals that should be dark
	set bg=dark
	" if there is defnoche installed change colors
	silent! colorscheme defnoche

	" to fix cursor shape in WSL bash
	" also add 
	" echo -ne "\e[2 q"
	" to .bashrc
	if &term =~ "xterm"
		let &t_SI = "\<Esc>[6 q"
		let &t_SR = "\<Esc>[3 q"
		let &t_EI = "\<Esc>[2 q"
	endif
endif
" 'I' in shortmess removes intro/welcome screen
set shortmess+=Ic
set winaltkeys=no
set guioptions=cme
set showtabline=1
set cmdheight=1
set nonumber norelativenumber
set winminwidth=0 winminheight=0
set lazyredraw
set splitbelow
set splitright
set helpheight=0
if !has('nvim') && has('patch-8.1.360')
	set diffopt=internal,filler,vertical,algorithm:patience
else
	set diffopt=filler,vertical
endif

" set completeopt+=menuone,noselect
set nofoldenable
set foldminlines=1 foldlevel=1
set scrolloff=2 sidescrolloff=5
set display+=lastline
set tabpagemax=50
" turn off if you use airline
set showmode

" Statusline {{{
fun! GitBranch()
	if exists('*fugitive#head')
		return fugitive#head()
	endif
	return ''
endfu
set laststatus=2
" set ruler " for default statusline"
set statusline=%([%R%M]%)
set statusline+=%<%f
set statusline+=%=
set statusline+=%([git:%{GitBranch()}]%)
set statusline+=\%y
set statusline+=%4(%p%%%)

" }}}

" Unicode chars {{{
" default ASCII listchars
" set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+,eol:$
" UTF-8 symbols, good font needed
" set listchars=tab:→\ ,eol:↲,trail:·,extends:⟩,precedes:⟨
set listchars=tab:→\ ,eol:↲,trail:·
" set listchars=tab:→\ ,eol:┐,trail:·

let &showbreak='↳ '
" set showbreak=╰
" set showbreak=└
set nolist
" ╙●↳→│↑←↓↘└┐
set fillchars=fold:\ ,vert:│

" My fancy foldtext
set foldtext=MyFoldText()
fu! MyFoldText()
	let line = getline(v:foldstart)

	" markdown frontmatter -- just take the next line hoping it would be
	" title: Your title
	if line =~ '^----*$'
		let line = getline(v:foldstart+1)
	endif

	let indent = max([indent(v:foldstart)-v:foldlevel, 1])
	let lines = (v:foldend - v:foldstart + 1)
	let strip_line = substitute(line, '^//\|=\+\|["#]\|/\*\|\*/\|{{{\d\=\|title:\s*', '', 'g')
	let strip_line = substitute(strip_line, '^[[:space:]]*\|[[:space:]]*$', '', 'g')
	let text = strpart(strip_line, 0, winwidth(0) - v:foldlevel - indent - 6 - strlen(lines))
	if strlen(strip_line) > strlen(text)
		let text = text.'…'
	endif
	return repeat('•', v:foldlevel) . repeat(' ', indent) . text .' ('. lines .')'
	" ▸•●□★▢▧▪◆▷▶┄◇□▢○◎
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
" highlight all occurrences of a term being searched/replaced
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

" CTRL-U in insert mode deletes a lot.	Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" spell correction for the first suggested
" https://castel.dev/post/lecture-notes-1/
inoremap <C-l> <c-g>u<C-\><C-o>[s<ESC>1z=`]a<c-g>u

" just one space on the line, preserving indent
" nnoremap <leader>tos :JustOneInnerSpace<CR>

" now it is possible to paste many times over selected text
" xnoremap <expr> p 'pgv"'.v:register.'y'

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
" nnoremap <Leader>ts :%s/\<<C-R><C-W>\>//gc<Left><Left><Left>

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
" nnoremap <Leader><leader>t :tabnew<CR>

nnoremap <Leader>cd :lcd %:p:h <bar> pwd<CR>

"" scroll other window
nnoremap <C-j> <C-w>p<C-e><C-w>p
nnoremap <C-k> <C-w>p<C-y><C-w>p

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

	if exists('+langremap')
		set nolangremap
	endif
endif

" Load Plugins and Abbreviations {{{1
runtime abbreviations.vim

if v:version >= 801 || has('nvim')
	runtime plugins.vim
endif
