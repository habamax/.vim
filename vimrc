" Author: Maxim Kim <habamax@gmail.com>

"" Must have {{{1
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

"" Encoding and fileformat {{{1
set encoding=utf8
set fileencoding=utf8
set fileformats=unix,mac,dos
set fileformat=unix

"" UI {{{1
if !has("gui_running")
	if exists('+termguicolors')
		set termguicolors
	endif
	if &term =~ "win32"
		set t_Co=256
	endif
	" for terminals that should be dark
	set bg=dark
	" if there is my dark theme installed -- use it
	silent! colorscheme lessthan

	" to fix cursor shape in WSL bash add 
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
set scrolloff=2 sidescrolloff=1
set display+=lastline
set tabpagemax=50
" turn off if you use airline
set showmode

"" Statusline {{{
func! StatusGitBranch()
	if exists('*fugitive#head')
		return fugitive#head()
	endif
	return ''
endfunc
func! StatusFiletype()
		return &filetype
	endif
endfunc

set laststatus=2
" set ruler " for default statusline"
set statusline=%([\%R%M]\ %)
set statusline+=%<%f
set statusline+=%(\ %y%)
set statusline+=%=
set statusline+=%([git:%{StatusGitBranch()}]%)
set statusline+=%4(%p%%%)

" }}}

"" Unicode chars {{{
" set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+,eol:$
" UTF-8 symbols, good font needed
" ⮌⭯⭮⮍⮎⮏⭲╙●↳→│↑←↓↘└┐⤶⤾⤶⤸⬎⮐␊␍⮠⮐
" set listchars=tab:→\ ,eol:↲,trail:·,extends:⟩,precedes:⟨
" set listchars=tab:⭲\ ,eol:↲,trail:·
" set listchars=tab:→\ ,eol:┐,trail:·
" let &showbreak='↳ '
" Fancy listchars for GUI, ASCII listchars for terminal
if has("gui_running")
	" set listchars=tab:>\ ,trail:·,eol:$
	set listchars=tab:⭲\ ,eol:⮠,trail:·
	" set listchars=tab:│\ ,eol:⮠,trail:·
	" set listchars=tab:│\ ,eol:$,trail:·
	" set listchars=tab:│\ ,eol:⮐,trail:·
	let &showbreak='⮎ '
	" set list
else
	set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+,eol:$
endif

set fillchars=fold:\ ,vert:│

" My fancy foldtext
set foldtext=MyFoldText()
func! MyFoldText()
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
endfunc
"}}}

" autocomplete is getting much better :e <tab>...
set wildchar=<Tab> wildmenu wildmode=full
set wildignore=*.o,*.obj,*.bak,*.exe,*.swp,*.pdf,*.docx,*.xlsx,*.png

" turn off beeping...
set visualbell
au! GuiEnter * set t_vb=
set t_vb=

"" Text {{{1
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

set nowrap
set nojoinspaces
set linebreak
set breakindent
set breakindentopt=sbr " showbreak will be handled correctly
set virtualedit=block
set textwidth=0

" neovim specific
if has('nvim')
	set inccommand=split
endif

set spelllang=ru,en
set nospell

set clipboard=unnamed

" backspace and cursor keys wrap to previous/next line
set backspace=indent,eol,start whichwrap+=<,>,[,]

set formatoptions=cqj
set textwidth=78

"" Encryption {{{1
if has('crypt-blowfish2')
	set cryptmethod=blowfish2
endif

"" Backup & Undo & Sessions {{{1
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

"" Mappings {{{1

" CTRL-U in insert mode deletes a lot.	Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" spell correction for the first suggested
" https://castel.dev/post/lecture-notes-1/
inoremap <C-l> <c-g>u<C-\><C-o>[s<ESC>1z=`]a<c-g>u

" just one space on the line, preserving indent
nnoremap <leader><leader><leader> :JustOneInnerSpace<CR>

" now it is possible to paste many times over selected text
xnoremap <expr> p 'pgv"'.v:register.'y`>'
xnoremap <expr> P 'Pgv"'.v:register.'y`>'

" change current word (like ciw) but repeatable with dot . for the same next
" word
nnoremap <silent> c<Tab> :let @/=expand('<cword>')<cr>cgn

" <C-l> redraws the screen and removes any search highlighting.
" nnoremap <silent> <C-l> :nohl<CR>:diffupdate<CR><C-l>


" Underline current line
nnoremap <leader>- "zyy"zp<c-v>$r-
nnoremap <leader>= "zyy"zp<c-v>$r=
nnoremap <leader><leader>- o<home><ESC>78i-<ESC>
nnoremap <leader><leader>= o<home><ESC>78i=<ESC>

" find visually selected text
vnoremap * y/<C-R>"<CR>

" edit init file (vimrc) -- nvim's init.vim sources vimrc
nnoremap <Leader>evi :exe "e " . fnamemodify($MYVIMRC, ":p:h")."/vimrc"<CR>
" edit gvim init file (gvimrc) -- nvim doesn't know about $GVIMRC and it's
" ginit.vim sources gvimrc
nnoremap <Leader>evg :exe "e " . fnamemodify($MYVIMRC, ":p:h")."/gvimrc"<CR>
" edit plugins settings file 
nnoremap <Leader>evs :exe "e " . fnamemodify($MYVIMRC, ":p:h")."/plugins.vim"<CR>
" edit plugins list file
nnoremap <Leader>evp :exe "e " . fnamemodify($MYVIMRC, ":p:h")."/minpac_list.vim"<CR>
" edit global notes file
nnoremap <Leader>en :e ~/docs/notes/notes.adoc<CR>
" edit global current journal file
nnoremap <Leader>ej :e ~/docs/journal/2019.adoc<CR>
" edit projects file
nnoremap <Leader>ep :e ~/docs/projects/project-paths.adoc<CR>

" built-in terminal
tnoremap <esc> <C-\><C-n>

nnoremap <Leader><tab> <C-^>
" nnoremap <Leader><leader>t :tabnew<CR>

nnoremap <Leader>cd :lcd %:p:h <bar> pwd<CR>

" helper func for scroll other window mappings
fun! s:scroll_other_window(dir)
	if winnr('$') < 2
		return
	endif
	wincmd w
	let cmd = "normal ".winheight(0)/2
	if a:dir
		let cmd .= "\<c-e>"
	else
		let cmd .= "\<c-y>"
	endif
	exe cmd
	wincmd p
endfu

" scroll other window
nnoremap <silent> <C-j> :call <SID>scroll_other_window(1)<CR>
nnoremap <silent> <C-k> :call <SID>scroll_other_window(0)<CR>


nnoremap <leader>ee :20Lexplore <bar> :set noscrollbind<CR>

"" Commands (and Autocommands) {{{1

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

" Continuous buffers.
" 1. Vertically split window
" 2. Offset it one screen
" 3. Scrollbind
command! SplitContinue 
			\exe "normal zR" 
			\|set noscrollbind
			\|vsplit
			\|exe "normal \<c-f>"
			\|set scrollbind
			\|wincmd p
			\|set scrollbind


" Not for Windows
" Write to a privileged file
if has("unix") || has("osxdarwin")
	command! W w !sudo tee "%" > /dev/null
endif

augroup restore_last_cursor_position
	autocmd!
	autocmd BufReadPost *
				\ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
				\ |   exe "normal! g`\""
				\ | endif
augroup END

fun! SetDefaultFiletype()
	if @% == "" && &filetype == ""
		setfiletype txt
	endif
endfu
augroup default_filetype
	autocmd!
	autocmd BufEnter * call SetDefaultFiletype()
augroup END

"" RU {{{1
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

"" Load Plugins and Abbreviations {{{1
runtime abbreviations.vim

if v:version >= 801 || has('nvim')
	runtime plugins.vim
endif
