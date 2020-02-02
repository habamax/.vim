" Author: Maxim Kim <habamax@gmail.com>

"" Must have {{{1
set nocompatible

" Everything will be in English
language messages en_US.UTF-8

filetype plugin indent on

" Clean all autocommands
autocmd!

syntax enable

set hidden
set confirm
set browsedir=buffer

let mapleader = "\<Space>"
let maplocalleader = "\<BS>"

if has('mouse')
	set mouse=a
endif

" Vim and terminals have hard time processing ESCs (laaaag)
" This helps a lot
set ttimeout
set ttimeoutlen=100

"" Encoding and fileformat {{{1
set encoding=utf8
set fileencoding=utf8
set fileformats=unix,mac,dos
set fileformat=unix

"" UI {{{1
if !has("gui_running")
	if exists('+termguicolors') && has("win32")
		set termguicolors
	endif

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
set guioptions=cMe
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

set scrolloff=2 sidescrolloff=0
set display+=lastline
set tabpagemax=50
set showmode

set conceallevel=0


"" Unicode chars
set listchars=tab:→\ ,eol:┘,trail:·
let &showbreak='└ '
set fillchars=fold:\ ,vert:│


" autocomplete is getting much better :e <tab>...
set wildchar=<Tab> wildmenu wildmode=full
set wildignore=*.o,*.obj,*.bak,*.exe,*.swp,*.pdf,*.docx,*.xlsx,*.png

" turn off beeping...
set novisualbell
au! GuiEnter * set t_vb=
set t_vb=

"" Text {{{1
set tabstop=8 softtabstop=-1 shiftwidth=0 noexpandtab smarttab
set shiftround
set autoindent

set nohlsearch incsearch ignorecase
" highlight all occurrences of a term being searched/replaced
augroup hlsearch-incsearch
	autocmd!
	autocmd CmdlineEnter /,\? :set hlsearch
	autocmd CmdlineLeave /,\? :set nohlsearch
augroup END

set nowrap
set nojoinspaces
set linebreak
set breakindent
set breakindentopt=sbr " showbreak will be handled correctly
set virtualedit=block
set formatoptions=cqjl
set textwidth=78

set completeopt=menuone
if !has('nvim') && v:version > 802 | set completeopt+=popup | endif

" neovim specific
if has('nvim')
	set inccommand=split
endif

set spelllang=ru,en
set nospell

set clipboard=unnamed

" backspace and cursor keys wrap to previous/next line
set backspace=indent,eol,start whichwrap+=<,>,[,]


"" Encryption {{{1
if has('crypt-blowfish2')
	set cryptmethod=blowfish2
endif

"" Mappings {{{1

" goto window
nnoremap <space>1 1<C-w>w
nnoremap <space>2 2<C-w>w
nnoremap <space>3 3<C-w>w
nnoremap <space>4 4<C-w>w
nnoremap <space>5 5<C-w>w
nnoremap <space>6 6<C-w>w
nnoremap <space>7 7<C-w>w
nnoremap <space>8 8<C-w>w
nnoremap <space>9 9<C-w>w

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

" " change current word (like ciw) but repeatable with dot . for the same next
" " word
" nnoremap <silent> c* :let @/=expand('<cword>')<cr>cgn

" <C-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR>:diffupdate<CR><C-l>

" Underline current line
func! s:underline(chars)
	let nextnr = line('.') + 1
	let underline = repeat(a:chars[0], strchars(getline('.')))
	if index(a:chars, trim(getline(nextnr))[0]) != -1
		call setline(nextnr, underline)
	else
		call append('.', underline)
	endif
endfunc
nnoremap <leader>- :call <SID>underline(['-', '=', '~', '^', '+'])<CR>
nnoremap <leader>= :call <SID>underline(['=', '-', '~', '^', '+'])<CR>
nnoremap <leader>~ :call <SID>underline(['~', '=', '-', '^', '+'])<CR>
nnoremap <leader>^ :call <SID>underline(['^', '=', '-', '~', '+'])<CR>
nnoremap <leader>+ :call <SID>underline(['+', '=', '-', '~', '^'])<CR>

nnoremap <leader><leader>- o<home><ESC>78i-<ESC>
nnoremap <leader><leader>= o<home><ESC>78i=<ESC>

" find visually selected text
vnoremap * y/<C-R>"<CR>

" edit init file (vimrc) -- nvim's init.vim sources vimrc
nnoremap <Leader>evi :exe "e " . fnamemodify($MYVIMRC, ":p:h")."/vimrc"<CR>
nmap <Leader>умш <Leader>evi
" edit gvim init file (gvimrc) -- nvim doesn't know about $GVIMRC and it's
" ginit.vim sources gvimrc
nnoremap <Leader>evg :exe "e " . fnamemodify($MYVIMRC, ":p:h")."/gvimrc"<CR>
nmap <Leader>умп <Leader>evg
" edit plugins settings file 
nnoremap <Leader>evs :exe "e " . fnamemodify($MYVIMRC, ":p:h")."/plugin_settings.vim"<CR>
nmap <Leader>умы <Leader>evs
" edit plugins list file
nnoremap <Leader>evp :exe "e " . fnamemodify($MYVIMRC, ":p:h")."/plugins.vim"<CR>
nmap <Leader>умз <Leader>evp
" edit global notes file
nnoremap <Leader>en :e ~/docs/notes/notes.adoc<CR>
nmap <Leader>ут <Leader>en
" edit global current journal file
nnoremap <Leader>ej :e ~/docs/journal/2019.adoc<CR>
nmap <Leader>уо <Leader>ej

" built-in terminal
tnoremap <esc> <C-\><C-n>

" helper func for scroll other window mappings
func! s:scroll_other_window(dir)
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
endfunc

" scroll other window
nnoremap <silent> <C-j> :call <SID>scroll_other_window(1)<CR>
nnoremap <silent> <C-k> :call <SID>scroll_other_window(0)<CR>


" nnoremap <leader>ee :20Lexplore <bar> :set noscrollbind<CR>
func! OpenExplorer()
	" Windows only for now
	if !has("win32")
		return
	endif

	if exists("b:netrw_curdir")
		let subcmd = '"' . substitute(b:netrw_curdir, "/", "\\", "g") . '"'
	elseif exists("b:dirvish")
		let subcmd = '/select,"' . getline('.') . '"'
	elseif expand("%:p") == ""
		let subcmd = '"' . expand("%:p:h") . '"'
	else
		let subcmd = '/select,"' . expand("%:p") . '"'
	endif
	:exe "silent !start explorer " . subcmd
endfunc
nnoremap <leader>oe :call OpenExplorer()<CR>

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
command! ContinueInSplit 
		\exe "normal zR" 
		\|set noscrollbind
		\|vsplit
		\|exe "normal \<c-f>"
		\|set scrollbind
		\|wincmd p
		\|set scrollbind


command! CD lcd %:p:h

" Not for Windows
" Write to a privileged file
if has("unix") || has("osxdarwin")
	command! W w !sudo tee "%" > /dev/null
endif

augroup restore_last_cursor_position | autocmd!
	autocmd BufReadPost *
			\ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
			\ |   exe "normal! g`\""
			\ | endif
augroup END

func! SetDefaultFiletype()
	if @% == "" && &filetype == ""
		setfiletype txt
	endif
endfunc
augroup default_filetype
	autocmd!
	autocmd BufEnter * call SetDefaultFiletype()
augroup END

"" Grepprg {{{1
if executable('rg')
	set grepprg=rg\ --vimgrep
	set grepformat=%f:%l:%c:%m
endif

"" Load Other Settings (plugins, colorscheme, etc) {{{1
silent! source <sfile>:h/foldtext.vim

silent! source <sfile>:h/paths.vim

silent! source <sfile>:h/russian.vim

silent! source <sfile>:h/statusline.vim

silent! source <sfile>:h/abbreviations.vim

silent! source <sfile>:h/colorscheme_setup.vim

if v:version >= 801 || has('nvim')
	source <sfile>:h/plugin_settings.vim
	source <sfile>:h/plugins.vim
endif
